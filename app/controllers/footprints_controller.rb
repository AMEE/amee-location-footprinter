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

    # let delayed job taker care of the processing
    Checkin.calculate_carbon_and_send_mail(u, current_user.checkins, request)

    redirect_to footprints_thanks_url

  end

  def thanks
    @user = User.find_or_create_by_foursquare_id(current_user.id)
  end

  def checkins
  end


end
