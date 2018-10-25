class DealershipsFinderServices
  EARTH_RADIUS = 6378137.0
  SMALL_CIRCLE_RADIUS = 2000.0 # 2km

  attr_reader :client

  def initialize()
    @client = GooglePlaces::Client.new(ENV['MAPS_API_KEY'])
  end

  def find(latitude, longitude, radius)
    circles = find_circles(latitude, longitude, radius)
    dealerships = find_nearby_places(circles)

    puts dealerships.inspect

    [dealerships, circles]
  end

  def find_circles(latitude, longitude, radius)
    final_latitude, final_longitude = add_offset_to_lat_lng(latitude, longitude, radius, radius)

    offset_x = -radius + SMALL_CIRCLE_RADIUS
    offset_y = -radius + SMALL_CIRCLE_RADIUS
    circle_latitude, circle_longitude = add_offset_to_lat_lng(
      latitude, longitude, offset_x, offset_y
    )
    initial_longitude = circle_longitude

    circles = [[circle_latitude, circle_longitude]]

    while circle_latitude - final_latitude < 0 && circle_longitude - final_longitude < 0 do
      _, circle_longitude = add_offset_to_lat_lng(circle_latitude, circle_longitude, SMALL_CIRCLE_RADIUS, 0.0)
      if circle_longitude > final_longitude
        circle_longitude = initial_longitude
        circle_latitude, _ = add_offset_to_lat_lng(circle_latitude, circle_longitude, 0.0, SMALL_CIRCLE_RADIUS)
      end

      circles << [circle_latitude, circle_longitude]
    end

    # dont want last element
    circles.pop
    circles
  end

  def add_offset_to_lat_lng(latitude, longitude, offset_x, offset_y)
    # offset in meters
    new_latitude = latitude + (offset_y / EARTH_RADIUS) * (180.0 / Math::PI)
    new_longitude = longitude +
      (offset_x / EARTH_RADIUS) * (180.0 / Math::PI) / Math.cos(latitude * Math::PI / 180.0)

    [new_latitude, new_longitude]
  end

  def find_nearby_places(circles)
    dealerships = []
    circles.each do |circle|
      # detail true makes an extra call to get the place details (website among other fields)
      dealership_spots = client.spots(circle[0], circle[1], radius: SMALL_CIRCLE_RADIUS,
        types: 'car_dealer', detail: true)

      dealerships << upsert_dealerships(dealership_spots)
    end

    dealerships.flatten.uniq
  end

  def upsert_dealerships(dealership_spots)
    dealerships = []
    dealership_spots.each do |dealership_spot|
      dealerships << Dealership.find_or_create_by(
        name: dealership_spot.name,
        website: dealership_spot.url,
        address_components: dealership_spot.address_components,
        formatted_address: dealership_spot.formatted_address,
        formatted_phone_number: dealership_spot.formatted_phone_number,
        international_phone_number: dealership_spot.international_phone_number,
        latitude: dealership_spot.lat,
        longitude: dealership_spot.lng,
        opening_hours: dealership_spot.opening_hours,
        google_place_id: dealership_spot.reference,
        tags: dealership_spot.types,
        country: dealership_spot.country,
        city: dealership_spot.city,
        rating: dealership_spot.rating
      )
    end
    dealerships
  end
end
