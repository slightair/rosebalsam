require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  fixtures :users, :clients

  def setup
    user = users(:alice)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
        provider: 'github',
        uid: user.uid,
        info: {name: user.name},
    )
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
  end

  test "GET /auth/github/callback" do
    get :callback, provider: 'github'
    assert_redirected_to root_path
  end

  test "GET /auth/github/callback?client=VALID_CODE" do
    get :callback, provider: 'github', client: 'aaaaaaaaaaaaaaaaaaaa'
    assert_redirected_to "iosApp://rosebalsam/callback?token=4edbb6a5ffd08893ec791db7e917a2c0901ca895"
  end

  test "GET /auth/github/callback?client=INVALID_CODE" do
    get :callback, provider: 'github', client: 'invalid'
    assert_response 404
  end
end
