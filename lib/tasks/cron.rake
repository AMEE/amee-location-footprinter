desc "A daily task for running on heroku to test"
task :cron => :environment do
  # in batches
  borked_users = []
  count = 0

  User.where("last_email_sent < ?", Time.now - 7.days).find_each(:batch_size => 200) do |user|
    
    begin
      foursquare_user = Foursquare::Base.new(user.token).users.find("self")
    rescue
      d "#{user.name}, #{user.id}, has oauth issues"
      borked_users << user
      next
    end

    # fetch the user's newest checkins
    checkins = foursquare_user.checkins

    # fetch the url of the app from environment, because we
    # we have no request object to rely on
    app_url = ENV['APP_URL']

    # if there are new ones, add them to the database, and
    # calculate the carbon and distance between them
    # then send the next email

    Checkin.parse_checkins(user, checkins)

    Checkin.calculate_carbon_and_send_mail(user, checkins, app_url)

  end

  d {borked_users}

end
