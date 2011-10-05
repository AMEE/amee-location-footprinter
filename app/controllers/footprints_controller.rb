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
    current_user.checkins.each do |checkin|    
      c = u.checkins.find_or_create_by_foursquare_id(checkin.id)
      # binding.pry
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
      end

    end

    
      @user_checkins = u.checkins

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
