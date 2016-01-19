class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.references :novel, index: true, foreign_key: true
      t.references :author, index: true
      t.string :name
      t.text :profile

      t.timestamps null: false
    end
    add_foreign_key :roles, :users, column: :author_id
  end
end
