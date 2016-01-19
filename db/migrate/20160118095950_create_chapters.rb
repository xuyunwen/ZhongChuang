class CreateChapters < ActiveRecord::Migration
  def change
    create_table :chapters do |t|
      t.references :novel, index: true, foreign_key: true
      t.integer :number
      t.references :author, class_name: 'Users', index: true, foreign_key: true
      t.integer :status
      t.references :cite, index: true, foreign_key: true
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

  end
end
