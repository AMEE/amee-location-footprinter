# Copyright (C) 2008-2011 AMEE UK Ltd. - http://www.amee.com
# Released as Open Source Software under the BSD 3-Clause license. See LICENSE.txt for details.

class Checkin < ActiveRecord::Base
  belongs_to :user

  has_one :outgoing_leg, :foreign_key => "start_checkin_id", :class_name => "Leg"
  has_one :incoming_leg, :foreign_key => "end_checkin_id", :class_name => "Leg"

  validates :lat, :lon, :foursquare_id, :timestamp, :venue_name, :timezone, :presence => true

  validates_uniqueness_of :foursquare_id

  def self.distance_between_points(checkin1, checkin2)

    distance = Haversine.distance(checkin1.lat.to_f, checkin1.lon.to_f, checkin2.lat.to_f, checkin2.lon.to_f)
    distance
  end

  def self.transport_method_image(distance)
    
    circumference_of_earth = 40075 # to the nearest km

    case distance.to_f
    when 0..1
      "walk.jpg"
    when 1..200
      "car.jpg"
    when 200..1000
      "plane.jpg" # domestic flight
    when 1000..3000
      "plane.jpg" # short haul flight
    when 3000...circumference_of_earth
      "plane.jpg" # long haul flight
    else
      "plane.jpg" # most likely option
    end

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

    if transport == 'walking'
      return 0
    else
      emission_model = AMEE::DataAbstraction::CalculationSet.find('calculations').calculations[transport]
      Checkin.calculate_co2e_for_distance(distance, emission_model)
    end
  end

  def self.co2_for_flight(checkin1, checkin2)

    c = AMEE::DataAbstraction::CalculationSet.find('calculations')[:route].begin_calculation

    c.choose(
      :lat1 => checkin1.lat.to_f,
      :long1 => checkin1.lon.to_f,
      :lat2 => checkin2.lat.to_f,
      :long2 => checkin1.lon.to_f
    )
    c.calculate!
    c[:lifeCycleCO2e].value
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

  def self.parse_checkins(user, checkin_payload)

    parsed_checkins = []
    checkin_payload.each_with_index do |checkin, index|

      if checkin.type == "checkin"
        c = Checkin.find_or_create_by_foursquare_id({
          :lat => checkin.json['type'] == 'venueless' ? checkin.json['location']['lat'] : checkin.venue.location.lat,
          :lon => checkin.json['type'] == 'venueless' ? checkin.json['location']['lng'] : checkin.venue.location.lng,
          :timestamp => checkin.created_at,
          :timezone => checkin.timezone,
          :venue_name => checkin.json['type'] == 'venueless' ? checkin.json['location']['name'] : checkin.venue.name,
          :foursquare_id => checkin.id,
          :icon => checkin.json['type'] == 'venueless' ? "https://foursquare.com/img/categories/none.png" : checkin.venue.icon,
          :user_id =>  user.id
        })

        parsed_checkins << c

      end
    end

    parsed_checkins.each_with_index do |checkin, index|
      next if index == 0
      prev_checkin = checkin
      current_checkin = parsed_checkins[index-1]  
        
      create_leg_from_checkins(user, prev_checkin, current_checkin)
    end

    

  rescue => err
    binding.pry if Rails.env.development?
    raise CheckinParseError
  end

  def self.create_leg_from_checkins(user, prev_checkin, current_checkin)

    # flights need different treatment, because we use a different algorithm
    # for calculating the CO2

    distance = distance_between_points(prev_checkin, current_checkin)

    l = user.legs.find_or_create_by_start_checkin_id_and_end_checkin_id({
      :start_checkin_id => prev_checkin.id,
      :end_checkin_id => current_checkin.id,
      :distance => distance.to_km,
      :co2 => 0,
      :name => "#{prev_checkin.venue_name} to #{current_checkin.venue_name}",
      :timestamp => current_checkin.timestamp,
      :timezone => current_checkin.timezone,
    })

  end

  def self.calculate_carbon(user, current_checkin, prev_checkin)

    distance = Checkin.distance_between_points(current_checkin, prev_checkin).to_km
    flight_carbon = Checkin.co2_for_flight(prev_checkin, current_checkin) if distance > 200

  rescue => err
    raise FlightCalculationError
  end

  def self.calculate_carbon_and_send_mail(user, checkins, app_url)
    # cache them in the database
    checkins.each_with_index do |checkin, index|
      next if index == 0 || checkin.type != "venue"

      # we need to be at least in the second iteration of the loop
      # fetch our prev_checkin object
      # make a compound index
      if index > 1
        prev_checkin = Checkin.find_by_foursquare_id(checkins[index-1].id)
      if prev_checkin == nil
        raise CheckinParseError "can't find Checkin for given foursquare id"
      end

      current_checkin = Checkin.find_by_foursquare_id(checkins[index].id)

      if current_checkin == nil
        raise CheckinParseError "can't find Checkin for given foursquare id"
      end

      Checkin.calculate_carbon(user, current_checkin, prev_checkin)
    end

  end

    # TODO turn to named scope - return list of checkins from the last 7 days
    @legs = user.legs.where("timestamp > ?", Date.current - 1.week )

    # using delay makes this act as a delayed job
    # http://rdoc.info/github/collectiveidea/delayed_job/master/file/README.textile#Gory_Details
    FootprintMailer.footprint_email(user, @legs, app_url).deliver!

  rescue => err
    binding.pry if Rails.env.development?
    raise "couldn't delegate mail to delayed job"
    
  end

  # When debugging, it may be useful to to comment out this line,
  # to make the mailng happen in a single process instead of 
  # relying on delayed job
  class << self
    handle_asynchronously :calculate_carbon_and_send_mail
  end

end

class MailDelegationError < Exception; end
class CheckinParseError < Exception; end
class DistanceError < Exception ;end
class FlightCalculationError < Exception ;end