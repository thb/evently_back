class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.references :place, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.datetime :occurs_at

      t.timestamps
    end
  end
end
