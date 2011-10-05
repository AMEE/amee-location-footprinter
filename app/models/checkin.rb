class Checkin < ActiveRecord::Base
    belongs_to :user
  
    validates :lat, :lon, :foursquare_id, :timestamp, :venue_name, :timezone, :presence => true

    def self.distance_between_points(checkin1, checkin2)

      distance = Haversine.distance(checkin1.lat.to_f, checkin1.lon.to_f, checkin2.lat.to_f, checkin2.lon.to_f)
      distance
    end

    def self.co2_for_km(distance)

      circumference_of_earth = 40075 # to the nearest km
      case distance
      when 0..1
        # AMEE always returns '0' for walking, so we can return 
        Checkin.carbon_for('walking', distance)
      when 1..200
        Checkin.carbon_for('car', distance)
      when 200..1000
        Checkin.carbon_for('domestic_flight', distance)
      when 1000..3000
        Checkin.carbon_for('short_haul_flight', distance)
      when 3000...circumference_of_earth
        Checkin.carbon_for('long_haul_flight', distance)
      else
        raise DistanceError, 'This distance is larger than the circumference of the Earth.', caller
      end

    end

    def self.carbon_for(transport, distance)
      return 0 if transport == 'walking'
      Checkin.calculate_co2e_for_distance(distance, Calculations[transport.to_sym])
    end

    def self.calculate_co2e_for_distance(distance, calculation_prototype)

      c = calculation_prototype.begin_calculation

      c.choose( 
      :amount => distance,
      :name => rand(10e6)
      )
      c.calculate!
      # add calculate and save here
      c[:co2e].value
    end

end

class DistanceError < Exception ;end
