class User < ActiveRecord::Base
  has_many :legs
  has_many :checkins, :through => :legs, :dependent => :destroy

  validates :email, :foursquare_id, :name, :presence => true

end
