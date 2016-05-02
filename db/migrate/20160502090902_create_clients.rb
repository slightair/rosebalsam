class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name, null: false
      t.string :code, limit: 20, null: false
      t.string :callback_url, null: false
      t.datetime :deleted_at

      t.timestamps null: false
    end
    add_index :clients, :code, unique: true
  end
end
