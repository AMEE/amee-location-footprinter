class FootprintMailer < ActionMailer::Base
  default :from => "CO4Squared <no-reply@amee.com>"

  def footprint_email(user, legs, application_url=nil)
    @user = user
    @legs = legs
    @total_co2 = 0
    # total up the co2 for email
    @legs.each { |leg| @total_co2 += leg.co2.to_f }   
    @url = application_url
    
    # binding.pry
    
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
