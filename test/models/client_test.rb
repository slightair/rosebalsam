require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  fixtures :clients

  test "active clients" do
    active_clients = Client.active
    assert_equal 2, active_clients.size

    client_names = active_clients.map(&:name)
    assert_includes client_names, "iOSApp"
    assert_includes client_names, "AndroidAppB"
  end

  test "callback_url_with" do
    client = clients(:ios_app)
    token = 'aaaaaaaaaaaaaaaaaaaa'
    assert_equal 'iosApp://rosebalsam/callback?token=aaaaaaaaaaaaaaaaaaaa', client.callback_url_with(token)
  end
end
