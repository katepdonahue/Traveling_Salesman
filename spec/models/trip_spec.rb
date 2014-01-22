require 'spec_helper'

describe Trip do

  trip = Trip.new
  trip.waypoints.build(:name => "Start", :address => "25 chapel st. Brooklyn, Ny 11201")
  trip.waypoints.build(:name => "center", :address => "900 Dekalb St. Brooklyn, NY 11221")
  trip.waypoints.build(:name => "otherfis", :address => "11 Broadway #260, New York, NY 10004")
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
    b = trip.waypoints[1]
    c = trip.waypoints[2]
    it "should return all the permutations" do
      expect(trip.ways).to eq([[b, c], [c, b]])
    end
  end

  describe "#pairs" do
    it "should return an array of the possible pairs in one way" do
      a = trip.waypoints[0]
      b = trip.waypoints[1]
      c = trip.waypoints[2]
      d = trip.waypoints[3]
      way = trip.ways.first
      expect(trip.pairs(way)).to eq([[a,b], [b,c], [c,d]])
    end
  end

  describe "#start?" do
    it "should return true if a waypoint has the name 'Start'" do
      expect(trip.start?).to eq(true)
    end
  end

  describe "#start" do
    it "should return the waypoint that has the name 'Start'" do
      expect(trip.start).to eq(trip.waypoints[0])
    end
  end

    describe "#end?" do
    it "should return true if a waypoint has the name 'End'" do
      expect(trip.end?).to eq(true)
    end
  end

  describe "#end" do
    it "should return the waypoint that has the name 'End'" do
      expect(trip.end).to eq(trip.waypoints[3])
    end
  end

end