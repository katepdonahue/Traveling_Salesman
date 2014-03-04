collection @routes
child :sub_routes do

  node do |sub_route|
    {
      :origin =>  Waypoint.find(sub_route.origin_waypoint_id).address,
      :destination =>  Waypoint.find(sub_route.destination_waypoint_id).address,
      :transitOptions => { :departure_time => Date.now} 
      :travelMode => "DRIVING"
    }
  end
end