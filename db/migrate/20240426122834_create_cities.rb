class CreateCities < ActiveRecord::Migration[7.1]
  def change
     create_table :cities do |t|
       t.string :name, null: false
       t.string :zip_code, null: false, unique: true
 
       t.timestamps
     end
     add_index :cities, :name, unique: true
     add_index :cities, :zip_code, unique: true
  end
 end
 