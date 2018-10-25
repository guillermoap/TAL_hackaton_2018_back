class DealershipsFinderServices
  API_BASE_URL = 'https://maps.googleapis.com/maps/api/place'
  EARTH_RADIUS = 6378137.0
  SMALL_CIRCLE_RADIUS = 2000.0 # 2km

  def initialize()
  end

  def find(latitude, longitude, radius)
    final_latitude, final_longitude = add_offset_to_lat_lng(latitude, longitude, radius, radius)

    offset_x = -radius + SMALL_CIRCLE_RADIUS
    offset_y = -radius + SMALL_CIRCLE_RADIUS
    circle_latitude, circle_longitude = add_offset_to_lat_lng(
      latitude, longitude, offset_x, offset_y
    )
    initial_longitude = circle_longitude

    puts '---------INITIAL----------'
    puts latitude
    puts longitude
    puts circle_latitude
    puts circle_longitude
    puts final_latitude
    puts final_longitude
    puts offset_x
    puts offset_y

    circles = [[circle_latitude, circle_longitude]]

    puts circle_latitude - final_latitude < 0
    puts circle_longitude - final_longitude < 0
    while circle_latitude - final_latitude < 0 && circle_longitude - final_longitude < 0 do
      _, circle_longitude = add_offset_to_lat_lng(circle_latitude, circle_longitude, SMALL_CIRCLE_RADIUS, 0.0)
      if circle_longitude.abs > final_longitude.abs
        circle_longitude = initial_longitude
        circle_latitude, _ = add_offset_to_lat_lng(circle_latitude, circle_longitude, 0.0, SMALL_CIRCLE_RADIUS)
      end

      circles << [circle_latitude, circle_longitude]


      puts circle_latitude
      puts circle_longitude
    end

    puts '----------------------------'
    puts circles

    [Dealership.all, circles]
  end

  def add_offset_to_lat_lng(latitude, longitude, offset_x, offset_y)
    # offset in meters
    new_latitude = latitude + (offset_y / EARTH_RADIUS) * (180.0 / Math::PI)
    new_longitude = longitude +
      (offset_x / EARTH_RADIUS) * (180.0 / Math::PI) / Math.cos(latitude * Math::PI / 180.0)

    [new_latitude, new_longitude]
  end
end
