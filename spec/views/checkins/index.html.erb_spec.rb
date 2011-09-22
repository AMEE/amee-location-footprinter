require 'spec_helper'

describe "checkins/index.html.erb" do
  before(:each) do
    assign(:checkins, [
      stub_model(Checkin,
        :lat => "Lat",
        :lon => "Lon",
        :foursquare_id => "Foursquare",
        :timezone => "Timezone"
      ),
      stub_model(Checkin,
        :lat => "Lat",
        :lon => "Lon",
        :foursquare_id => "Foursquare",
        :timezone => "Timezone"
      )
    ])
  end

  it "renders a list of checkins" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Lat".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Lon".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Foursquare".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Timezone".to_s, :count => 2
  end
end
