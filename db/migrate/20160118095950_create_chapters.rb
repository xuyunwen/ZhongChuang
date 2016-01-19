class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.references :novel, index: true, foreign_key: true
      t.integer :number
      t.references :author, index: true
      t.integer :status
      t.references :cite, index: true
      t.string :title, index:true
      t.text :content
      t.text :summary
      t.text :subsequent_summary
      t.text :foreshadowing
      t.boolean :draft, default:true

      t.timestamps null: false
    end
    add_index :chapters, :number
    add_index :chapters, [:novel_id, :number, :author_id]

    add_foreign_key :chapters, :users, column: :author_id
    add_foreign_key :chapters, :chapters, column: :cite_id
  end
end
