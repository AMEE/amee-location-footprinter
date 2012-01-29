# Copyright (C) 2008-2011 AMEE UK Ltd. - http://www.amee.com
# Released as Open Source Software under the BSD 3-Clause license. See LICENSE.txt for details.

class FootprintsController < ApplicationController

  before_filter :require_user

  def user
    @total_co2 = 0

    u = User.find_or_create_by_foursquare_id(current_user.id)
      u.update_attributes!({
        :email => current_user.email,
        :name => current_user.name,
        :foursquare_id => current_user.id,
        :last_email_sent => Date.current - 8.day,
        :token => session[:access_token]
      })

    # build list of id's to iterate through from latest list of checkins
    checkins = Checkin.parse_checkins(u, current_user.checkins)
    # fetch our url for emailing
    app_url = request.host_with_port || ENV['APP_URL'] 
    # let delayed job take care of the processing
    Checkin.calculate_carbon_and_send_mail(u, checkins, app_url)
    binding.pry
    if u.legs.blank?
      redirect_to footprints_thanks_url
    else
      redirect_to legs_url
    end


  end

  def thanks
    @user = User.find_or_create_by_foursquare_id(current_user.id)
  end

  def checkins
  end


end
