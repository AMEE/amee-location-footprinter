class Leg < ActiveRecord::Base

  has_one :start_checkin, :class_name => :checkin
  has_one :end_checkin, :class_name => :checkin

  belongs_to :user
  validates :co2, :distance, :presence => true
end
