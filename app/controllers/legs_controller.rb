class LegsController < ApplicationController

  before_filter :require_user

  def index
    u = User.find_by_foursquare_id(current_user.id)
    begin
      d params
      @given_week = Time.parse(params[:week_end_date])
    rescue
      d params
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

  def show
    u = User.find_by_foursquare_id(current_user.id)
    @leg = u.legs.where(:id => params[:id]).first
  end

  def edit
    u = User.find_by_foursquare_id(current_user.id)
    @leg = u.legs.where(:id => params[:id]).first
  end

end
