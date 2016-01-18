class CreateUserGroups < ActiveRecord::Migration
  def change
    create_table :user_groups do |t|
      t.string :name

      t.timestamps null: false
    end

    add_index :user_groups, :name, unique: true
  end
end
