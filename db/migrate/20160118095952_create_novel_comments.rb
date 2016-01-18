class CreateNovelComments < ActiveRecord::Migration
  def change
    create_table :novel_comments do |t|
      t.references :novel, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
    end

    add_index :novel_comments, [:novel_id, :user_id]
  end
end
