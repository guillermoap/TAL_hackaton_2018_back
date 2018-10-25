json.dealerships_count @dealerships.try(:count)
json.dealerships @dealerships do |dealership|
  json.id dealership.id
  json.name dealership.name
  json.website dealership.website
  json.formatted_address dealership.formatted_address
  json.formatted_phone_number dealership.formatted_phone_number
  json.latitude dealership.latitude
  json.longitude dealership.longitude
  json.opening_hours dealership.opening_hours
  json.tags dealership.tags
  json.rating dealership.rating
end
json.circles @circles do |circle|
  json.latitude circle[0]
  json.longitude circle[1]
end
