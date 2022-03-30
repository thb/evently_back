class CreatePlaces < ActiveRecord::Migration[7.0]
  def change
    create_table :places do |t|
      t.string :name
      t.string :address
      t.string :lat
      t.string :lng
      t.string :street_number
      t.string :street
      t.string :city
      t.string :country

      t.timestamps
    end
  end
end
