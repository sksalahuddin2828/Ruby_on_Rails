require 'ruby2d'

SCREEN_WIDTH = 800
SCREEN_HEIGHT = 600
EARTH_RADIUS = 6371
NUM_SATELLITES = 10
SATELLITE_RADIUS = 100
SATELLITE_COLOR = 'red'

class SatelliteOrbit
  attr_reader :semi_major_axis, :eccentricity

  def initialize
    @semi_major_axis = 800 + rand(700)
    @eccentricity = 0.1 + rand(0.3)
  end
end

satellites = Array.new(NUM_SATELLITES) { SatelliteOrbit.new }

set width: SCREEN_WIDTH, height: SCREEN_HEIGHT, title: 'Satellite Orbits'

update do
  clear

  # Draw Earth
  for i in 0..99
    for j in 0..49
      u = i * 2 * Math::PI / 100
      v = j * Math::PI / 50
      x = (EARTH_RADIUS * Math.cos(u) * Math.sin(v)).to_i + SCREEN_WIDTH / 2
      y = (EARTH_RADIUS * Math.sin(u) * Math.sin(v)).to_i + SCREEN_HEIGHT / 2
      Square.new(x: x, y: y, size: 1, color: [135, 206, 250])
    end
  end

  # Draw satellite orbits and markers
  satellites.each do |satellite|
    points = []
    for i in 0..99
      r = satellite.semi_major_axis * (1 - satellite.eccentricity ** 2) / (1 + satellite.eccentricity * Math.cos(i * 2 * Math::PI / 100))
      x = (r * Math.cos(i * 2 * Math::PI / 100)).to_i + SCREEN_WIDTH / 2
      y = (r * Math.sin(i * 2 * Math::PI / 100)).to_i + SCREEN_HEIGHT / 2
      points << [x, y]
    end

    Line.new(x1: points[0][0], y1: points[0][1], x2: points[-1][0], y2: points[-1][1], width: 1, color: 'gray')

    last_point = points[-1]
    Circle.new(x: last_point[0], y: last_point[1], radius: SATELLITE_RADIUS, sectors: 32, color: SATELLITE_COLOR)
  end
end

show
