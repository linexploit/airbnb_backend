class CreateReservations < ActiveRecord::Migration[7.1]
  def change
     create_table :reservations do |t|
       t.datetime :start_date, null: false
       t.datetime :end_date, null: false
       t.references :user, foreign_key: true
       t.references :listing, foreign_key: true
 
       t.timestamps
     end
  end
 end
 