# Copyright (C) 2008-2011 AMEE UK Ltd. - http://www.amee.com
# Released as Open Source Software under the BSD 3-Clause license. See LICENSE.txt for details.

source 'http://rubygems.org'

gem 'rails', '~> 3.1.3'
gem 'log_buddy'
gem 'pg'

# handy foursquare library
gem 'quimby'

# local library for calculating distance between two latlng points
# on the globe
gem 'haversine'

# take the rendering of the information out of the page request cycle
gem 'delayed_job', :git => 'git://github.com/collectiveidea/delayed_job.git', :branch => "v2.1"

gem 'bootstrap-sass'
gem 'mechanize'


# relevant amee gems
gem 'amee'
gem 'amee-data-abstraction'
# gem 'amee-data-persistence', '~> 1.1.0'


# Adding Railsadmin gems
gem 'fastercsv' # Only required on Ruby 1.8 and below
gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git'
gem 'airbrake'

# not needed right now
# gem 'aasm','2.3.1'
# gem 'amee-auth'
# gem 'amee-analytics'
# gem 'amee-data-classify'


gem 'jquery-rails','~> 1.0.16'

group :development, :test do
  gem 'gem-open'
  gem 'sqlite3'
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'capybara'
  # gem 'net-http-spy'

  gem 'guard'
  gem 'guard-rspec'
  # only install the fsevent gem for guard, if we're on a mac
  gem 'rb-fsevent',   :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'growl_notify', :require => false if RUBY_PLATFORM =~ /darwin/i

  # for investigating errors
  gem 'pry'
  gem 'pry-doc'

  # Preview email in the browser instead of sending it.
  # We're using a different fork because ryanb's one
  # has a small error reported here, with a pending pull request
  # https://github.com/ryanb/letter_opener/pull/15
  gem "letter_opener", :git => "git://github.com/pcg79/letter_opener.git"
  # gem "vagrant", '~> 0.9.0'
  # setting up mechanize for form manipulation
  # gem 'mechanize'
  gem 'thin'
end

group :test do
  gem 'timecop'
  gem 'rspec', '~> 2.6.0'
  gem 'rspec-rails'
  gem "factory_girl_rails",'~> 1.2.0'
  gem 'redgreen'
  gem 'webmock', '~>1.7.0'
  gem 'vcr'
  gem 'flexmock'
end


group :cucumber do 
  gem 'cucumber-rails'
  gem 'database_cleaner'
end


gem "devise"
gem 'rack-google_analytics', :require => "rack/google_analytics"
