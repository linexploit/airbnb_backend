class CreateListings < ActiveRecord::Migration[7.1]
  def change
     create_table :listings do |t|
       t.integer :available_beds, null: false
       t.integer :price, null: false
       t.text :description, null: false, limit: 140
       t.boolean :has_wifi, null: false
       t.text :welcome_message, null: false
       t.references :user, foreign_key: true
       t.references :city, foreign_key: true
 
       t.timestamps
     end
  end
 end
 