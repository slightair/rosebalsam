class MakeNotNullColumns < ActiveRecord::Migration
  def up
    change_column :tokens, :user_id, :integer, null: false
    change_column :tokens, :token, :string, null: false
    change_column :users, :name, :string, null: false
    change_column :users, :provider, :string, null: false
    change_column :users, :uid, :string, null: false
  end

  def down
    change_column :tokens, :user_id, :integer, null: true
    change_column :tokens, :token, :string, null: true
    change_column :users, :name, :string, null: true
    change_column :users, :provider, :string, null: true
    change_column :users, :uid, :string, null: true
  end
end
