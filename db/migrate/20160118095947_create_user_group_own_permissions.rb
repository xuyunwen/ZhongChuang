class CreateUserGroupOwnPermissions < ActiveRecord::Migration
  def change
    create_table :user_group_own_permissions do |t|
      t.references :user_group, index: true, foreign_key: true
      t.integer :user_level
      t.references :permission, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :user_group_own_permissions, [:user_group_id, :user_level, :permission_id], name: 'index_ugop_on_user_group_and_user_level_and_permission'
  end
end
