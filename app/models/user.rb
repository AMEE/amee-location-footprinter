class User < ActiveRecord::Base
  has_many :checkins, :dependent => :destroy

  validates :email, :foursquare_id, :name, :presence => true

end
