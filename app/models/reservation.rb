class Reservation < ApplicationRecord
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_after_start_date
  belongs_to :user
  belongs_to :listing

 
  def duration
     (end_date - start_date).to_i
  end
 
  private
 
  def end_date_after_start_date
     errors.add(:end_date, "must be after start date") if end_date < start_date
  end
 end
 