class Leg < ActiveRecord::Base

  belongs_to :start_checkin, :class_name => "Checkin"
  belongs_to :end_checkin, :class_name => "Checkin"

  belongs_to :user
  validates :co2, :distance, :presence => true
end
