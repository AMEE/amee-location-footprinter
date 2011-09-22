class Checkin < ActiveRecord::Base
    validates :lat, :lon, :foursquare_id, :timestamp, :presence => true 
end