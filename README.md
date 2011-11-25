# AMEE Location Footprinter (A.L.F.)

With this app, you're able to sign in with your Foursquare account, and see the cumulative carbon footprint of your travels from checkin to checkin in your Foursquare history.

Licensed under the BSD 3-Clause license (See LICENSE.txt for details)

Authors: Chris Adams

Copyright: Copyright (c) 2011 AMEE UK Ltd

Homepage: http://github.com/amee/amee->

Documentation: <DOCUMENTATION LINK>

### INSTALLATION

# AMEE Location Footprinter (A.L.F.)

## How to set this up

(Assuming you have bundler installed)

First clone the repo:

    git clone https://github.com/AMEE/amee-location-footprinter.git

Then run bundler - it should fetch all the relevant dependencies

    bundle install

Once you have this you'll need credentials from foursquare to allow users to grant access to their checkins, and you'll need an API key from AMEE to make carbon calculations.


#### Get your API keys

##### FourSquare

Once you're signed with Foursquare (we assume you have an account the service), head along to https://foursquare.com/oauth, And register the application name, website and callback url. You'll need these because Foursquare will redirect your browser back to this address once you've authenticated with them. The good news here is that because you are working from your browser, you can happily enter http://localhost:3000 (or http://alf.dev) as your home page url, and http://localhost:3000/user/callback (or http://alf.dev/user/callback) as your callback url for testing and local development.

Once you have these set, add them to config/foursquare.yml like so:

    defaults: &defaults
      client_id: YOUR_CLIENT_ID
      client_secret: YOUR_CLIENT_SECRET
      redirect_url: http://localhost:3000/user/callback

    development:
      <<: *defaults

    test:
      <<: *defaults

    production:
      <<: *defaults

###### AMEE

Next fetch your credentials from AMEE, at https://my.amee.com/login. You'll need to sign up (it's free), then create a *Standard project*, giving it a name and url to visit it at.

Click the name of your project and you'll be able to fetch the username and password from it, add add to the amee.yml file, like so:

    defaults: &defaults
      server: stage.amee.com
      username: YOUR_PROJECT_NAME
      password: YOUR_PASSWORD

    development:
      <<: *defaults

    test:
      <<: *defaults

    production:
      <<: *defaults

##### Set up your database:

Create your database, then run your migrations `rake db:migrate` or simply call `rake db:schema:load` to skip all the updates.


== REQUIREMENTS

This has been tested with Rails 3.1.2, running on Ruby 1.8.7 and 1.9.2. Postgres is the default database adapter on this project (because this was developed to run on Heroku), but MySQL and SQLite should both work too.

== USAGE

Start your local server, then make sure you have the delayed job worker running with `rake jobs:work`, so that emails are sent in a different process to the main rails request-response cycle. 

Voila! Your own version of location footprinter is setup. Now get hacking!
