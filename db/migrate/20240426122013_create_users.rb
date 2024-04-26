class CreateUsers < ActiveRecord::Migration[7.1]
  def change
     create_table :users do |t|
       t.string :email, null: false, unique: true
       t.string :phone_number, null: false
       t.text :description
 
       t.timestamps
     end
     add_index :users, :email, unique: true
     add_index :users, :phone_number, unique: true
  end
 end
 