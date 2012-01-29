# Copyright (C) 2008-2011 AMEE UK Ltd. - http://www.amee.com
# Released as Open Source Software under the BSD 3-Clause license. See LICENSE.txt for details.

# Load in the relevant yaml file, to set them in the Rails configuration object
def foursquare_api_config
  foursquare_config = YAML.load_file("#{Rails.root}/config/foursquare.yml")
  foursquare_config[Rails.env]
end

# Add the details to the config object
Rails.configuration.foursquare_client_id = ENV['FOURSQUARE_CLIENT_ID'] || foursquare_api_config['client_id']
Rails.configuration.foursquare_client_secret = ENV['FOURSQUARE_CLIENT_SECRET'] || foursquare_api_config['client_secret']
Rails.configuration.foursquare_redirect_url = ENV['FOURSQUARE_REDIRECT_URL'] || foursquare_api_config['redirect_url']
# if we want to refresh the responses, passing in the oauth2_code lets us fetch new responses
Rails.configuration.foursquare_access_token = ENV['ACCESS_TOKEN'] || foursquare_api_config['access_token']