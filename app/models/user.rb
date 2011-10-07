class User < ActiveRecord::Base
  has_many :legs
  has_many :checkins, :through => :legs, :dependent => :destroy

  validates :email, :foursquare_id, :name, :presence => true

  def first_name
    self.name.split(' ')[0]
  end

end
