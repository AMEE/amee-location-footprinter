require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the FootprintHelper. For example:
#
describe FootprintsHelper do  
    
  it "should give the distance between two latlngs, using the haversine formula" do
    checkin1 = FactoryGirl.build(:checkin, :lat => "51.514667", :lon => "-0.136047") # Off Broadway Bar, London
    checkin2 = FactoryGirl.build(:checkin, :lat => "51.502557", :lon => "-0.07253941") # The Marksman Pub, London
    helper.distance_between_points(checkin1, checkin2).to_meters.should be_within(0.1).of(4596.84510626154)
  end
  
end
