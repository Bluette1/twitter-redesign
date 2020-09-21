class CreateThoughts < ActiveRecord::Migration[6.0]
  def change
    create_table :thoughts do |t|
      t.text :text, null: false, limit: 1000
      t.references :author, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
