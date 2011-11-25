# Copyright (C) 2008-2011 AMEE UK Ltd. - http://www.amee.com
# Released as Open Source Software under the BSD 3-Clause license. See LICENSE.txt for details.

Airbrake.configure do |config|
  config.api_key = ENV['AIRBRAKE_API_KEY']
end
