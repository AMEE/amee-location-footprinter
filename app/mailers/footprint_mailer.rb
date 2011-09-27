class FootprintMailer < ActionMailer::Base
  default :from => "from@example.com"

  def footprint_email(user)
    @user = user
    @total_co2 = 0
    @url  = "http://example.com/login"
    mail(:to => user.email, :subject => "Check out your Checkins")
  end

end
