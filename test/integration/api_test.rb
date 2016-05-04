require 'test_helper'

class ApiTest < ActionDispatch::IntegrationTest
  fixtures :users, :tokens

  test "GET /api/v1/me with invalid token" do
    get "/api/v1/me", nil, HTTP_AUTHORIZATION: 'Token INVALID'
    assert_response :unauthorized
  end

  test "GET /api/v1/me with valid token" do
    get "/api/v1/me", nil, HTTP_AUTHORIZATION: 'Token 4edbb6a5ffd08893ec791db7e917a2c0901ca895'
    assert_response :success

    result = JSON.parse response.body
    assert_includes result.to_a, ['name', 'Alice']
    assert_includes result.to_a, ['provider', 'github']
    assert_includes result.to_a, ['uid', '100']
  end
end
