# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
      email "chris.adams@amee.com"
      token "2FJJKFXC2LBIYGNPJHOX1KXOOR0ZTYVEISA24LRFCZYEPPWL"
      name "Chris Adams"
      foursquare_id "7661144"
      last_email_sent DateTime.now
    end
end

