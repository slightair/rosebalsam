require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :tokens, :users

  test "alice's token" do
    alice = users(:alice)
    assert_equal "4edbb6a5ffd08893ec791db7e917a2c0901ca895", alice.token
  end

  test "bob's token" do
    bob = users(:bob)
    assert_equal "2706d6900e47a84ddadb9912ded170ae24e58f18", bob.token
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
    assert_not_equal "4edbb6a5ffd08893ec791db7e917a2c0901ca895", alice.token
  end
end
