module FootprintsHelper

  # TODO make distance formatting methods here to avoid excessively long figures

  def distance_between_points(checkin1, checkin2)

    distance = Haversine.distance(checkin1.lat.to_f, checkin1.lon.to_f, checkin2.lat.to_f, checkin2.lon.to_f)
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
