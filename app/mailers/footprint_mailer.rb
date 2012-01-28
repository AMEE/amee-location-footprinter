# Copyright (C) 2008-2011 AMEE UK Ltd. - http://www.amee.com
# Released as Open Source Software under the BSD 3-Clause license. See LICENSE.txt for details.

class FootprintMailer < ActionMailer::Base
  default :from => "AMEE Location Footprinter <no-reply@amee.com>"

  def footprint_email(user, legs, application_url=nil)
    @user = user
    @legs = legs
    @total_co2 = 0
    @url = application_url

    # total up the co2 for email
    @legs.each do |leg| 
      d { leg }
      d { leg.co2 }
      @total_co2 += leg.co2.to_f 
    end

    send_email_and_update_last_sent(@user)
  end

  def send_email_and_update_last_sent(user)
    user.update_attributes!(:last_email_sent => DateTime.now)
    mail(:to => user.email, :subject => "This week's footprints, from AMEE Location Footprinter")
  end

end
