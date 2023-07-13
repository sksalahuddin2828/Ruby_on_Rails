require 'json'
require 'open-uri'
require 'skyfield'
require 'matplotlib/pyplot'

include Math

class SatelliteData
  attr_accessor :name, :tle_line1, :tle_line2, :angle
end

class SatelliteDbEntry
  attr_accessor :name, :country
end

def send_get_request(url)
  response = ''
  begin
    response = URI.open(url).read
  rescue StandardError => e
    puts "Error in send_get_request: #{e.message}"
  end
  response
end

begin
  # Step 1: Retrieve satellite data from the API
  satellite_data_api_url = 'API_URL_HERE'
  satellite_data_json = send_get_request(satellite_data_api_url)
  satellite_data = JSON.parse(satellite_data_json, object_class: SatelliteData)

  # Step 2: Parse TLE data using Skyfield
  tle_data = satellite_data.map { |satellite| [satellite.tle_line1, satellite.tle_line2] }

  # Step 3: Visualize satellite orbits in 3D
  loader = Skyfield::Loader.new('path_to_data_directory')
  ephemeris = loader.load('de421.bsp')
  satellites = loader.parse_tle_file(tle_data)

  fig = Matplotlib::Pyplot.figure()
  ax = fig.add_subplot(111, projection: '3d')

  satellites.each do |satellite|
    # Calculate the satellite's position over time
    ts = loader.make_timescale
    t = ts.utc(2023, 7, 11, 0, (0..3600).map { |x| x * 60 })
    geocentric = satellite.at(t)
    subpoint = geocentric.subpoint

    # Extract latitude, longitude, and altitude
    latitude = subpoint.latitude.degrees
    longitude = subpoint.longitude.degrees
    altitude = subpoint.elevation.km

    # Plot the satellite's trajectory in 3D
    ax.plot(longitude, latitude, altitude)
  end

  ax.set_xlabel('Longitude')
  ax.set_ylabel('Latitude')
  ax.set_zlabel('Altitude (km)')

  # Step 4: Map satellites to countries using the satellite database API
  satellite_db_api_url = 'SATELLITE_DB_API_URL_HERE'
  satellite_db_json = send_get_request(satellite_db_api_url)
  satellite_db = JSON.parse(satellite_db_json, object_class: SatelliteDbEntry)

  # Mapping satellite names to countries
  satellite_country_map = {}
  satellite_data.each do |satellite|
    name = satellite.name
    entry = satellite_db.find { |e| e.name == name }
    country = entry ? entry.country : 'Unknown'
    satellite_country_map[name] = country
  end

  # Printing satellite information
  satellite_data.each do |satellite|
    name = satellite.name
    angle = satellite.angle
    country = satellite_country_map[name]

    puts "Satellite Name: #{name}"
    puts "Orbital Angle: #{angle} degrees"
    puts "Country: #{country}"
    puts
  end

  # Show the 3D plot
  Matplotlib::Pyplot.show
rescue StandardError => e
  puts "Error: #{e.message}"
end
