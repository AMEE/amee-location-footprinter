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

    # if u.legs.blank?
      redirect_to footprints_thanks_url
    # else
    #   redirect_to footprints_mine_url
    # end


  end

  def thanks
    @user = User.find_or_create_by_foursquare_id(current_user.id)
  end

  def checkins
  end

  def mine
    u = User.find_by_foursquare_id(current_user.id)
    begin
      @given_week = Time.parse(params[:week])
    rescue
      @given_week = Time.now
    end

      @given_week_before = @given_week-1.week
      @legs = u.legs.where(:timestamp => @given_week_before..@given_week)
      @sunday_legs = u.legs.where(:timestamp => @given_week-1.day..@given_week)
      @saturday_legs = u.legs.where(:timestamp => @given_week-2.day..@given_week-1.day)
      @friday_legs = u.legs.where(:timestamp => @given_week-3.day..@given_week-2.day)
      @thursday_legs = u.legs.where(:timestamp => @given_week-4.day..@given_week-3.day)
      @wednesday_legs = u.legs.where(:timestamp => @given_week-5.day..@given_week-4.day)
      @tuesday_legs = u.legs.where(:timestamp => @given_week-6.day..@given_week-5.day)
      @monday_legs = u.legs.where(:timestamp => @given_week-7.day..@given_week-6.day)
  end

end
