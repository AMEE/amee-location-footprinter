# Copyright (C) 2008-2011 AMEE UK Ltd. - http://www.amee.com
# Released as Open Source Software under the BSD 3-Clause license. See LICENSE.txt for details.

class User < ActiveRecord::Base
  has_many :legs
  has_many :checkins, :dependent => :destroy

  validates :email, :foursquare_id, :name, :presence => true

  def first_name
    self.name.split(' ')[0]
  end

end
