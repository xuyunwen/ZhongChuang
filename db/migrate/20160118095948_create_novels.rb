class CreateNovels < ActiveRecord::Migration
  def change
    create_table :novels do |t|
      t.string :name
      t.binary :cover
      t.references :category, index: true, foreign_key: true
      t.integer :status, default: 0

      t.timestamps null: false
    end
    add_index :novels, :name
  end
end
