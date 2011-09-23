module FootprintsHelper

  # TODO make distance formatting methods here to avoid excessively long figures

  def distance_between_points(checkin1, checkin2)
    
    # https://github.com/kristianmandrup/haversine/blob/master/lib/haversine.rb
    # self.distance(lat1, lon1, lat2=nil, lon2=nil)
    lon1 = checkin1.venue.location.lng
    lat1 = checkin1.venue.location.lat
    
    lon2 = checkin2.venue.location.lng
    lat2 = checkin2.venue.location.lat
  
    distance = Haversine.distance(lat1, lon1, lat2, lon2)
    distance
  end

def carbon_for_distance(distance)

    c = Calculations[:car].begin_calculation

    c.choose( 
    :amount => distance,
    :name => rand(10e6)
    )

    c.calculate!
    # add calculate and save here
    c[:co2e]
  end
end
