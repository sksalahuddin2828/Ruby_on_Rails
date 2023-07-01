# gem install ruby2d

require 'ruby2d'

SCREEN_WIDTH = 1850
SCREEN_HEIGHT = 1850
SUN_RADIUS = 50

# Planet data: name, radius, orbit radius, orbit speed, color
PLANETS = [
  ["Mercury", 10, 100, 0.02, [128, 128, 128]],
  ["Venus", 15, 150, 0.015, [255, 165, 0]],
  ["Earth", 20, 200, 0.01, [0, 0, 255]],
  ["Mars", 17, 250, 0.008, [255, 0, 0]],
  ["Jupiter", 40, 350, 0.005, [255, 215, 0]],
  ["Saturn", 35, 450, 0.004, [210, 180, 140]],
  ["Uranus", 30, 550, 0.003, [0, 255, 255]],
  ["Neptune", 30, 650, 0.002, [0, 0, 139]],
  ["Pluto", 8, 750, 0.001, [165, 42, 42]]
]

class CelestialBody
  attr_reader :name, :radius, :orbit_radius, :orbit_speed, :color, :angle

  def initialize(name, radius, orbit_radius, orbit_speed, color)
    @name = name
    @radius = radius
    @orbit_radius = orbit_radius
    @orbit_speed = orbit_speed
    @color = color
    @angle = 0
  end

  def update(dt)
    @angle += @orbit_speed * dt
  end

  def get_position
    x = SCREEN_WIDTH / 2 + Math.cos(@angle) * @orbit_radius
    y = SCREEN_HEIGHT / 2 + Math.sin(@angle) * @orbit_radius
    [x, y]
  end

  def calculate_volume
    volume = (4 / 3.0) * Math::PI * @radius ** 3
    volume.round(2)
  end

  def calculate_surface_area
    surface_area = 4 * Math::PI * @radius ** 2
    surface_area.round(2)
  end

  def calculate_orbital_velocity
    return Float::INFINITY if @orbit_speed.zero?
    orbital_velocity = 2 * Math::PI * @orbit_radius / @orbit_speed
    orbital_velocity.round(2)
  end
end

def create_celestial_body(name, radius, orbit_radius, orbit_speed, color)
  CelestialBody.new(name, radius, orbit_radius, orbit_speed, color)
end

def draw_celestial_body(body)
  x, y = body.get_position

  # Display the name
  Text.new(body.name, x: x, y: y + body.radius + 20, size: 16, color: 'white')

  # Perform scientific calculations for each planet
  volume = body.calculate_volume
  surface_area = body.calculate_surface_area
  orbital_velocity = body.calculate_orbital_velocity

  # Display the calculations on console
  puts "Planet: #{body.name}"
  puts "Volume: #{volume}"
  puts "Surface Area: #{surface_area}"
  puts "Orbital Velocity: #{orbital_velocity}"
  puts "-------------------"

  # Draw the body
  Circle.new(
    x: x, y: y, radius: body.radius,
    sectors: 100, color: body.color
  )
end

set(title: 'Planetary System', width: SCREEN_WIDTH, height: SCREEN_HEIGHT)

sun = create_celestial_body('Sun', SUN_RADIUS, 0, 0, [255, 255, 0])
planets = PLANETS.map { |planet_data| create_celestial_body(*planet_data) }

update do
  dt = get(:delta_time) / 1000.0

  planets.each { |planet| planet.update(dt) }

  clear

  planets.each { |planet| draw_celestial_body(planet) }
  draw_celestial_body(sun)
end

show
