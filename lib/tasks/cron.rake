desc "A daily task for running on heroku to test"
task :cron => :environment do
  # in batches
  User.where("last_email_sent < ?", Time.now - 7.days).find_each(:batch_size => 200) do |user|

    # fetch checkins with user's API token
    foursquare_user = Foursquare.new(user.token).users.find("self")

    # fetch the user's newest checkins
    checkins = foursquare_user.checkins

    # fetch the url of the app from environment, because we
    # we have no request object to rely on
    app_url = ENV['APP_URL']

    # if there are new ones, add them to the database, and
    # calculate the carbon and distance between them
    # then send the next email
    Checkin.calculate_carbon_and_send_mail(u, checkins, app_url)
  end

end
