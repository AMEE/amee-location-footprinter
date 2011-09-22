require 'spec_helper'

describe "checkins/show.html.erb" do
  before(:each) do
    @checkin = assign(:checkin, stub_model(Checkin,
      :lat => "Lat",
      :lon => "Lon",
      :foursquare_id => "Foursquare",
      :timezone => "Timezone"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Lat/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Lon/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Foursquare/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Timezone/)
  end
end
