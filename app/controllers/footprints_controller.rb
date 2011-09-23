class FootprintsController < ApplicationController

  before_filter :require_user

  def index
    # list all the examples
  end

  def user
    @total_co2 = 0
    @user_checkins = current_user.checkins    
  end

  def checkins
  end

end
