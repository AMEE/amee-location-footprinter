# Load in the relevant yaml file, to set them in the Rails configuration object
def foursquare_api_config
  foursquare_config = YAML.load_file("#{Rails.root}/config/foursquare.yml")
  foursquare_config[Rails.env]
end

# Add the details to the config object
Rails.configuration.foursquare_client_id = ENV['FOURSQUARE_CLIENT_ID'] || foursquare_api_config['client_id']
Rails.configuration.foursquare_client_secret = ENV['FOURSQUARE_CLIENT_ID'] || foursquare_api_config['client_secret']
Rails.configuration.foursquare_redirect_url = ENV['FOURSQUARE_REDIRECT_URL'] || foursquare_api_config['redirect_url']
