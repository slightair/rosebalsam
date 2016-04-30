class RemoveOauthTokenFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :oauth_token, :string
  end
end
