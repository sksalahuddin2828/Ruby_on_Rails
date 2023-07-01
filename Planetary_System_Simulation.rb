# This code uses the ruby2d gem to create a graphical window and render the celestial bodies.
# To run this code, make sure you have the ruby2d gem installed (gem install ruby2d)

require 'ruby2d'

SCREEN_WIDTH = 1900
SCREEN_HEIGHT = 1900

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
    @angle += orbit_speed * dt
  end

  def position
    x = SCREEN_WIDTH / 2 + Math.cos(angle) * orbit_radius
    y = SCREEN_HEIGHT / 2 + Math.sin(angle) * orbit_radius
    [x, y]
  end

  def calculate_volume
    volume = (4.0 / 3.0) * Math::PI * radius**3
    volume.round(2)
  end

  def calculate_surface_area
    surface_area = 4.0 * Math::PI * radius**2
    surface_area.round(2)
  end

  def calculate_orbital_velocity
    return Float::INFINITY if orbit_speed.zero?

    orbital_velocity = (2.0 * Math::PI * orbit_radius) / orbit_speed
    orbital_velocity.round(2)
  end
end

def create_celestial_body(name, radius, orbit_radius, orbit_speed, color)
  CelestialBody.new(name, radius, orbit_radius, orbit_speed, color)
end

def draw_celestial_body(body)
  x, y = body.position

  # Perform scientific calculations for each planet
  volume = body.calculate_volume
  surface_area = body.calculate_surface_area
  orbital_velocity = body.calculate_orbital_velocity

  # Print calculations to console
  puts "Scientific Calculations:"
  puts "Planet: #{body.name}"
  puts "Volume: #{volume}"
  puts "Surface Area: #{surface_area}"
  puts "Orbital Velocity: #{orbital_velocity}"
  puts "------------------------"

  # Render the calculations as text on the screen
  Text.new("Volume: #{volume}", x: x, y: y + body.radius + 20)
  Text.new("Surface Area: #{surface_area}", x: x, y: y + body.radius + 40)
  Text.new("Orbital Velocity: #{orbital_velocity}", x: x, y: y + body.radius + 60)

  # Draw the body
  Circle.new(
    x: x, y: y,
    radius: body.radius,
    sectors: 32,
    color: body.color
  )
end

set width: SCREEN_WIDTH, height: SCREEN_HEIGHT
set title: "Planetary System"

sun = create_celestial_body("Sun", SUN_RADIUS, 0, 0, [255, 255, 0])
planets = PLANETS.map { |data| create_celestial_body(*data) }

update do
  dt = get :delta_time

  planets.each { |planet| planet.update(dt) }

  clear

  planets.each { |planet| draw_celestial_body(planet) }
  draw_celestial_body(sun)
end

show
