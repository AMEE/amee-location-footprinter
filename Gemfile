source 'http://rubygems.org'

gem 'rails', '3.0.10'

# gem 'mysql'

# handy foursquare library
gem 'quimby'

# local library for calculating distance between two latlng points
# on the globe
gem 'haversine'

# take the rendering of the information out of the page request cycle
gem 'delayed_job'

# relevant amee gems
gem 'amee','~> 4.1.1'
gem 'amee-data-abstraction', '~> 2.0.0'
# gem 'amee-data-persistence', '~> 1.1.0'

# not needed right now
# gem 'aasm','2.3.1'
# gem 'amee-auth'
# gem 'amee-analytics'
# gem 'amee-data-classify'

gem 'jquery-rails','~> 1.0.12'

group :development, :test do
  gem 'gem-open'
  gem 'sqlite3'
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'capybara'
  gem 'net-http-spy'
  gem 'guard'
  gem 'guard-rspec'
  # only install the fsevent gem for guard, if we're on a mac
  gem 'rb-fsevent',   :require => false if RUBY_PLATFORM =~ /darwin/i 
  gem 'growl_notify', :require => false if RUBY_PLATFORM =~ /darwin/i 
  gem 'pry'
  # Preview email in the browser instead of sending it.
  gem "letter_opener"
end

group :test do
  gem 'timecop'
  gem 'rspec', '~> 2.6.0'
  gem 'rspec', '~> 2.6.0'
  gem 'rspec-rails'
  gem 'shoulda', '~> 2.11.3'
  gem "factory_girl_rails",'~> 1.2.0'
  gem 'redgreen'
  gem 'webmock', '~>1.7.0'
  gem 'vcr'
  gem 'flexmock'
end
