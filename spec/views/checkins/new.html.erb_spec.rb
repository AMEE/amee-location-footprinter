require 'spec_helper'

describe "checkins/new.html.erb" do
  before(:each) do
    assign(:checkin, stub_model(Checkin,
      :lat => "MyString",
      :lon => "MyString",
      :foursquare_id => "MyString",
      :timezone => "MyString"
    ).as_new_record)
  end

  it "renders new checkin form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => checkins_path, :method => "post" do
      assert_select "input#checkin_lat", :name => "checkin[lat]"
      assert_select "input#checkin_lon", :name => "checkin[lon]"
      assert_select "input#checkin_foursquare_id", :name => "checkin[foursquare_id]"
      assert_select "input#checkin_timezone", :name => "checkin[timezone]"
    end
  end
end
