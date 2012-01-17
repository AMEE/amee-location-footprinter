# Copyright (C) 2008-2011 AMEE UK Ltd. - http://www.amee.com
# Released as Open Source Software under the BSD 3-Clause license. See LICENSE.txt for details.

class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  def about

  end

  private

    def require_user
      unless current_user
        redirect_to root_path
      end
    end

    def current_admin

      if current_user.present?
        return current_user
      else
        redirect_to '/' and return
      end

    end

    def current_user
      return nil if session[:access_token].blank?
      begin
        foursquare = Foursquare::Base.new(session[:access_token])
        @current_user ||= foursquare.users.find("self")
      rescue Foursquare::InvalidAuth
        nil
      end
    end

    def foursquare
      unless current_user
        client_id = Rails.configuration.foursquare_client_id
        client_secret = Rails.configuration.foursquare_client_secret

        @foursquare ||= Foursquare::Base.new(client_id, client_secret)
      else
        @foursquare ||= Foursquare::Base.new(session[:access_token])
      end
    end
end
