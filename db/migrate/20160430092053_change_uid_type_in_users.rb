class ChangeUidTypeInUsers < ActiveRecord::Migration
  def up
    change_column :users, :uid, :string
  end

  def down
    change_column :users, :uid, :text
  end
end
