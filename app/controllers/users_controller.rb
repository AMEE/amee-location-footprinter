class UsersController < ApplicationController
  def new
    return redirect_to footprints_user_path if current_user
    @authorize_url = foursquare.authorize_url("http://localhost:5000/user/callback")

  end

  def callback
    code = params[:code]
    @access_token = foursquare.access_token(code, "http://localhost:5000/user/callback")
    session[:access_token] = @access_token
    
    redirect_to footprints_user_path

  end

end
