require "spec_helper"

describe CheckinsController do
  describe "routing" do

    it "routes to #index" do
      get("/checkins").should route_to("checkins#index")
    end

    it "routes to #new" do
      get("/checkins/new").should route_to("checkins#new")
    end

    it "routes to #show" do
      get("/checkins/1").should route_to("checkins#show", :id => "1")
    end

    it "routes to #edit" do
      get("/checkins/1/edit").should route_to("checkins#edit", :id => "1")
    end

    it "routes to #create" do
      post("/checkins").should route_to("checkins#create")
    end

    it "routes to #update" do
      put("/checkins/1").should route_to("checkins#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/checkins/1").should route_to("checkins#destroy", :id => "1")
    end

  end
end
