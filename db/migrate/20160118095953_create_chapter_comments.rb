class CreateChapterComments < ActiveRecord::Migration
  def change
    create_table :chapter_comments do |t|
      t.references :chapter, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
    end

    add_index :chapter_comments, [:chapter_id, :user_id]
  end
end
