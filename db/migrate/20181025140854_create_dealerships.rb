class CreateDealerships < ActiveRecord::Migration[5.1]
  def change
    create_table :dealerships do |t|
      t.string :name
      t.string :website
      t.jsonb :address_components, default: []
      t.string :formatted_address
      t.string :formatted_phone_number
      t.string :international_phone_number
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6
      t.jsonb :opening_hours, default: []
      t.string :google_place_id, unique: true
      t.text :tags, array: true, default: []
      t.string :country
      t.string :city
      t.decimal :rating, precision: 2, scale: 1

      t.timestamps
    end

    add_index :dealerships, :name
    add_index :dealerships, :website
    add_index :dealerships, :latitude
    add_index :dealerships, :longitude
    add_index :dealerships, :google_place_id
    add_index :dealerships, :tags
    add_index :dealerships, :country
    add_index :dealerships, :city
  end
end
