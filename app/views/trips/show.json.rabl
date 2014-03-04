object false
@routes.each do |route|
  node route.id.to_sym do
    "hello"
  end
end