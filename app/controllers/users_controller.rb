class UsersController < ApplicationController
  def new
    redirect_url = Rails.configuration.foursquare_redirect_url
    return redirect_to footprints_user_path if current_user
    @authorize_url = foursquare.authorize_url(redirect_url)

  end

  def callback
    redirect_url = Rails.configuration.foursquare_redirect_url
    code = params[:code]
    @access_token = foursquare.access_token(code, redirect_url)
    session[:access_token] = @access_token
    
    redirect_to footprints_user_url

  end

end
