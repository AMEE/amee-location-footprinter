class LegsController < ApplicationController

  before_filter :require_user

  def index
    u = User.find_by_foursquare_id(current_user.id)
    begin
      @chosen_week = Time.parse(params[:chosen_week])
    rescue
      @chosen_week = Time.now
    end

    @legs = u.legs.where(:timestamp => @chosen_week.beginning_of_week..@chosen_week.end_of_week)

    # Filter days into keys in a hash for the template
    @days = {};
    ["Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"].each do |day|
      @days[day.downcase] = @legs.select { |l| l.day_is? day }
    end

  end

  def show
    u = User.find_by_foursquare_id(current_user.id)
    @leg = u.legs.where(:id => params[:id]).first
  end

  def edit
    u = User.find_by_foursquare_id(current_user.id)
    @leg = u.legs.where(:id => params[:id]).first
  end

  def update
    u = User.find_by_foursquare_id(current_user.id)    
    @leg = u.legs.where(:id => params[:id]).first
    
    if @leg.update_attributes!(params[:leg])
      redirect_to(@leg, :notice => 'Journey leg successfully updated.')
    end
    
  end

  private

end
