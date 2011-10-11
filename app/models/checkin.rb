class Checkin < ActiveRecord::Base
    belongs_to :user

    has_one :outgoing_leg, :foreign_key => "start_checkin_id", :class_name => "Leg"
    has_one :incoming_leg, :foreign_key => "end_checkin_id", :class_name => "Leg"

    validates :lat, :lon, :foursquare_id, :timestamp, :venue_name, :timezone, :presence => true

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

    def self.calculate_carbon_and_send_mail(user, checkins, request)

      # cache them in the database
      checkins.each_with_index do |checkin, index|
        c = user.checkins.find_or_create_by_foursquare_id(checkin.id)

        if c.new_record?

          c.update_attributes!({
           :lat => checkin.json['type'] == 'venueless' ? checkin.json['location']['lat'] : checkin.venue.location.lat,
           :lon => checkin.json['type'] == 'venueless' ? checkin.json['location']['lng'] : checkin.venue.location.lng,
           :timestamp => checkin.created_at,
           :timezone => checkin.timezone,
           :venue_name => checkin.json['type'] == 'venueless' ? checkin.json['location']['name'] : checkin.venue.name,
           :foursquare_id => checkin.id,
           :icon => checkin.json['type'] == 'venueless' ? "https://foursquare.com/img/categories/none.png" : checkin.venue.icon 
          })
          c.save!

          # we need to be at least in the second iteration of the loop
          # fetch our prev_checkin object
          if index > 0
            # make a compound index
            prev_checkin = Checkin.find_by_foursquare_id(checkins[index-1].id)
            current_checkin = Checkin.find_by_foursquare_id(checkins[index].id)

            # surely there's a nicer way to  write this?
            l = user.legs.find_or_initialize_by_start_checkin_id_and_end_checkin_id(prev_checkin.id, current_checkin.id)

            if l.new_record?
              distance = Checkin.distance_between_points(current_checkin, prev_checkin).to_km

              l.update_attributes!({
               :distance => distance,
               :co2 => Checkin.co2_for_km(distance),
               :timestamp => current_checkin.timestamp,
               :timezone => current_checkin.timezone,
              })

              l.save!
            end

          end
        end
      end
      # TODO turn to named scope - return list of checkins from the last 7 days
      @legs = user.legs.where("timestamp > ?", Date.current-107.day )

      # using delay makes this act as a delayed job
      # http://rdoc.info/github/collectiveidea/delayed_job/master/file/README.textile#Gory_Details
      FootprintMailer.footprint_email(user, @legs, request.host_with_port).deliver!

    end

    class << self
      handle_asynchronously :calculate_carbon_and_send_mail
    end





end

class DistanceError < Exception ;end
