# Copyright (C) 2008-2011 AMEE UK Ltd. - http://www.amee.com
# Released as Open Source Software under the BSD 3-Clause license. See LICENSE.txt for details.

class UsersController < ApplicationController
  def new
    # binding.pry
    redirect_url = Rails.configuration.foursquare_redirect_url
    return redirect_to footprints_user_path if current_user
    @authorize_url = foursquare.authorize_url(redirect_url)

  end

  def callback
    # binding.pry
    redirect_url = Rails.configuration.foursquare_redirect_url
    code = params[:code]
    @access_token = foursquare.access_token(code, redirect_url)
    session[:access_token] = @access_token

    redirect_to footprints_user_url

  end

end
