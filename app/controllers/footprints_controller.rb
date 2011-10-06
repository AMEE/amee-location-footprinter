class FootprintsController < ApplicationController

  before_filter :require_user

  def user
    @total_co2 = 0

    u = User.find_or_create_by_foursquare_id(current_user.id)
    if u.new_record?
      u.update_attributes!({
        :email => current_user.email,
        :name => current_user.name,
        :foursquare_id => current_user.id,
        :last_email_sent => Date.current - 8.day
        })

      end
      # cache them in the database
      current_user.checkins.each_with_index do |checkin, index|
        c = u.checkins.find_or_create_by_foursquare_id(checkin.id)

        if c.new_record?

          c.update_attributes!({
            :lat => checkin.json['type'] == 'venueless' ? checkin.json['location']['lat'] : checkin.venue.location.lat,
            :lon => checkin.json['type'] == 'venueless' ? checkin.json['location']['lng'] : checkin.venue.location.lng,
            :timestamp => checkin.created_at,
            :timezone => checkin.timezone,
            :venue_name => checkin.json['type'] == 'venueless' ? checkin.json['location']['name'] : checkin.venue.name,
            :foursquare_id => checkin.id,
            })
            c.save!

            # we need to be at least in the second iteration of the loop
            # fetch our prev_checkin object
            if index > 0

              l = u.legs.find_or_create_by_id()

              if l.new_record?
                prev_checkin = Checkin.find_by_foursquare_id(current_user.checkins[index-1].id)
                current_checkin = Checkin.find_by_foursquare_id(current_user.checkins[index].id)
                distance = Checkin.distance_between_points(current_checkin, prev_checkin).to_km

                l.update_attributes!({
                  :distance => distance,
                  :co2 => Checkin.co2_for_km(distance),
                  :timestamp => current_checkin.timestamp,
                  :timezone => current_checkin.timezone,
                  :start_checkin => prev_checkin,
                  :end_checkin => current_checkin
                  })
                end

              end
            end

          end



          @user_checkins = u.checkins

          # TODO turn to named scope - return list of checkins from the last 7 days
          @legs = Leg.where("timestamp > ?", Date.current - 7.day )

          # using delay makes this act as a delayed job
          # http://rdoc.info/github/collectiveidea/delayed_job/master/file/README.textile#Gory_Details
          FootprintMailer.delay.footprint_email(u, current_user.checkins, request.host_with_port)

          redirect_to footprints_thanks_url
        end

        def thanks
          @user = User.find_or_create_by_foursquare_id(current_user.id)
        end

        def checkins
        end

      end
