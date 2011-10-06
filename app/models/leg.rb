class Leg < ActiveRecord::Base
  has_many :checkins,  :dependent => :destroy
  belongs_to :user
  validates :co2, :distance, :presence => true
end
