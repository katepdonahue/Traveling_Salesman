require 'spec_helper'

describe Trip do

  trip = Trip.new
  trip.waypoints.build(:name => "Start", :address => "25 chapel st. Brooklyn, Ny 11201")
  trip.waypoints.build(:name => "End", :address => "Empire State Building")
  
  describe "#to_mins" do
    it "should work for singular hours and mins" do
      trip.stub(:time => "1 hour 1 min")
      expect(trip.to_mins(0, 1)).to eq(61)
    end
    it "should work for plural hours and mins" do
      trip.stub(:time => "2 hours 3 mins")
      expect(trip.to_mins(0, 1)).to eq(123)
    end
  end

  describe "#ways" do

  end

  describe "#pairs" do

  end

  describe "#start?" do
    it "should return true if a waypoint has the name 'Start'" do
      expect(trip.start?).to eq(true)
    end

  end

end