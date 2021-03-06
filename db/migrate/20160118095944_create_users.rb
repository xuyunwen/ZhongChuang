class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :nick_name
      t.binary :header
      t.references :user_group, index: true, foreign_key: true, default:0
      t.integer :level, default:1
      t.string :password_digest
      t.string :remember_digest

      t.timestamps null: false
    end
    add_index :users, :user_name, unique: true
  end
end
