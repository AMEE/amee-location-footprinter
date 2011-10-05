class FootprintMailer < ActionMailer::Base
  default :from => "CO4Squared <no-reply@amee.com>"

  def footprint_email(user, checkins=nil, application_url=nil)
    @user = user
    @checkins = checkins
    @total_co2 = 0
    @url = application_url
    
    # if ( @user.last_email_sent < Date.current.ago(7) )
      send_email_and_update_last_sent(@user)
    # end
    # check the time and only send the last email was sent more than a week ago

  end

  def send_email_and_update_last_sent(user)
    user.update_attributes!(:last_email_sent => DateTime.now)
    mail(:to => user.email, :subject => "Your Carbon Fourprint for the week")
  end

end

