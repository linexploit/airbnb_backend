class Listing < ApplicationRecord
  belongs_to :user
  belongs_to :city
  has_many :reservations
  validates :available_beds, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :description, presence: true, length: { minimum: 140 }
  validates :has_wifi, inclusion: { in: [true, false] }
  validates :welcome_message, presence: true
 
  def overlaping_reservation?(datetime)
     reservations.where("start_date <= ? AND end_date >= ?", datetime, datetime).exists?
  end
 end
 