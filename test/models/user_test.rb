require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :tokens, :users

  test "alice's token" do
    alice = users(:alice)
    assert_equal "TOKEN_ALICE_2", alice.token
  end

  test "bob's token" do
    bob = users(:bob)
    assert_equal "TOKEN_BOB_1", bob.token
  end

  test "create token after created user" do
    tom = User.create(
        name: "tom",
        provider: "github",
        uid: 300,
    )
    assert_not_nil tom.token
  end

  test "renew token when already user exist" do
    alice = users(:alice)
    prev_token = alice.tokens.active.first
    assert_nil prev_token.deleted_at

    alice.create_token

    prev_token.reload
    assert_not_nil prev_token.deleted_at
    assert_not_equal "TOKEN_ALICE_2", alice.token
  end
end
