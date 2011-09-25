class Checkin < ActiveRecord::Base
    belongs_to :user
  
    validates :lat, :lon, :foursquare_id, :timestamp, :venue_name, :presence => true
     
end