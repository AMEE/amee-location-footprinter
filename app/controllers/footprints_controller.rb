class FootprintsController < ApplicationController

  before_filter :require_user

  def user
    @total_co2 = 0

    u = User.find_or_create_by_foursquare_id(current_user.id)
    if u.new_record?

      u.update_attributes!({
        :email => current_user.email,
        :name => current_user.name,
        :foursquare_id => current_user.id
      })

    end
    # cache them in the database
    current_user.checkins.each do |checkin|    
      c = u.checkins.find_or_create_by_foursquare_id(checkin.id)

      if c.new_record?
        c.update_attributes!({
          :lat => checkin.venue.location.lat, 
          :lon => checkin.venue.location.lat, 
          :timestamp => checkin.created_at, 
          :venue_name => checkin.venue.name, 
          :foursquare_id => checkin.id
          })
          c.save!
      end

    end
      @user_checkins = u.checkins
  end

  def checkins
  end

end
