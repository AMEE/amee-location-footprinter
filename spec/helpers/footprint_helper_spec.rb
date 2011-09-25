require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the FootprintHelper. For example:
#
describe FootprintsHelper do  
    
  it "gives the distance between to latlngs, using the haversine formula" do
    off_broadway_bar_london = [51.514667, -0.136047]
    the_marksman_pub = [51.502557, -0.07253941]
    helper.distance_between_points(off_broadway_bar_london, the_marksman_pub).to_meters.should be_within(0.1).of(4596.84510626154)
  end
end
