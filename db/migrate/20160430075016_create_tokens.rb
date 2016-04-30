class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.references :user, index: true, foreign_key: true
      t.string :token
      t.datetime :deleted_at

      t.timestamps null: false
    end
    add_index :tokens, :token, unique: true
  end
end
