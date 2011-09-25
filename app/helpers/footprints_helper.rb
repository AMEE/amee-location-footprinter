module FootprintsHelper

  # TODO make distance formatting methods here to avoid excessively long figures

  def distance_between_points(checkin1, checkin2)

    distance = Haversine.distance(checkin1.lat.to_f, checkin1.lon.to_f, checkin2.lat.to_f, checkin2.lon.to_f)
    distance
  end

  # Looks at the distance passed in, and makes the relevant call
  # to the AMEE abstraction layer.
  # 
  # @param [Float] Distance of the journey we're trying to measure for
  def co2_for_km(distance)
    case distance
    when 0..1
      # AMEE always returns '0' for walking, so we can return 
      carbon_for('walking', distance)
    when 1..200
      carbon_for('car', distance)
    when 200..1000
      carbon_for('domestic_flight', distance)
    when 1000..3000
      carbon_for('short_haul_flight', distance)
    when distance > 3000
      carbon_for('long_haul_flight', distance)
    end
  end

  def carbon_for(transport, distance)
    puts "#{transport}, #{distance}"
    return 0 if transport == 'walking'
    calculate_co2e_for_distance(distance, Calculations[transport.to_sym])
  end



  def calculate_co2e_for_distance(distance, calculation_prototype)
    
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
