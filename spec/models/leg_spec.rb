require 'spec_helper'

describe Leg do

  # set up a user, then two checkins then a single leg

  it "should have a beginning checkin" do
    # pending
    @checkin2 = FactoryGirl.build(:checkin)
    @leg = FactoryGirl.build(:leg, :start_checkin => nil, :end_checkin => @checkin2)
    @leg.save
    @leg.should_not be_valid
  end

  it "should have an arrival checkin" do
    @checkin2 = FactoryGirl.build(:checkin), 
    @leg = FactoryGirl.build(:leg, :start_checkin => @checkin2, :end_checkin => nil)
    @leg.save
    @leg.should_not be_valid
  end

  it "should have distance between checkins" do
    @leg = FactoryGirl.build(:leg, :distance => "")
    @leg.save
    @leg.should_not be_valid
  end

  it "should have a name" do
    @leg = FactoryGirl.build(:leg, :name => "")
    @leg.save
    @leg.should_not be_valid
  end

  it "should have a co2 reading" do
    @leg = FactoryGirl.build(:leg, :co2 => nil)
    @leg.save
    @leg.should_not be_valid
  end

  it "should have a mode of transport" do
    @leg = FactoryGirl.build(:leg, :mode_of_transport => nil)
    @leg.save
    @leg.should_not be_valid
  end

  context "updating attributes that require extra calculation" do 

    before(:each) do

      @checkin1 = FactoryGirl.create(
        :checkin, 
        :lat => "51.5302391808239", 
        :lon => "-0.190415382385254", 
        :id => 10
      )
      @checkin2 = FactoryGirl.create(
        :checkin, :lat => "51.5917302346968", 
        :lon => "-0.069644669476303", 
        :id => 11,
        :foursquare_id => "4dde05bc1f6e0369473a10fb"
      )
      @leg = FactoryGirl.create(:leg, 
        :mode_of_transport => "car", 
        :end_checkin => @checkin1, 
        :start_checkin => @checkin2, 
        :distance => "not set"
      )
    end

    it "allows recalculations of distance" do

      @leg.distance.should == "not set"
      @leg.recalculate_distance!
      @leg.distance.should be_within(0.1).of 10.7912288632373

    end

    it "recalculates CO2e if journey methods change" do

      # We expect Checkin.carbion_for to be called, because it's
      # a callback.
      # We don't want to really hit the API, so we're mocking this call.

      # this doesn't work, because we're not directly calling methods on it,
      # so 
      
      # BUT! Calling this AND the ont below will cause this test to fail
      # chuff knows why
      # a_full_mock = flexmock('Checkin')
      # a_full_mock.should_receive(:carbon_for).once.and_return(0)
      
      d { a_full_mock.object_id }
      d { a_full_mock.class }      
      
      # this DOES work, assuming because it's making changes to a real object
      # that exists outside the scope of this example.
      a_partial_mock = flexmock(Checkin)
      
      a_partial_mock.should_receive(:carbon_for).once.and_return(0)
      
      d { a_partial_mock.object_id }
      d { a_partial_mock.class }

      # binding.pry

      # We all
      flexmock(AMEE::DataAbstraction::OngoingCalculation).new_instances do |mock|
        mock.should_receive(:choose).and_return(nil)
        mock.should_receive(:calculate!).and_return(nil)
        mock.should_receive(:[]).with(:co2e).and_return(flexmock(:value => 42))
      end

      @leg.mode_of_transport.should == "car"
      # binding.pry
      @leg.update_attributes({ :mode_of_transport => "walking" })
      # binding.pry
      @leg.save!

      
    end

  end


end
