class CreateChapterVotes < ActiveRecord::Migration
  def change
    create_table :chapter_votes do |t|
      t.references :chapter, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :rate

      t.timestamps null: false
    end
  end
end
