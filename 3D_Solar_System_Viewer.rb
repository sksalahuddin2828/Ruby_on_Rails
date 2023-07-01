require 'ruby-processing'

class SolarSystemSketch < Processing::App
  def setup
    size(800, 800, P3D)
    background(255)
    no_loop
  end

  def draw
    background(255)
    draw_solar_system
  end

  def draw_solar_system
    data = {
      'Name' => ['Sun', 'Mercury', 'Venus', 'Earth', 'Mars', 'Jupiter', 'Saturn', 'Uranus', 'Neptune'],
      'Type' => ['Star', 'Planet', 'Planet', 'Planet', 'Planet', 'Planet', 'Planet', 'Planet', 'Planet'],
      'x' => [0, 0.39, 0.72, 1.0, 1.52, 5.20, 9.58, 19.18, 30.07],
      'y' => [0, 0, 0, 0, 0, 0, 0, 0, 0],
      'z' => [0, 0, 0, 0, 0, 0, 0, 0, 0]
    }

    df = create_dataframe(data)

    # Plot the Sun
    sun = df[df['Name'] == 'Sun']
    draw_planet(sun['x'][0], sun['y'][0], sun['z'][0], 500, color(255, 255, 0))

    # Plot the planets
    planets = df[df['Type'] == 'Planet']
    planets.each do |planet|
      draw_planet(planet['x'], planet['y'], planet['z'], 50, color(0, 0, 255))
    end

    # Set the axis labels
    lights
    translate(width / 2, height / 2, -200)
    rotate_x(PI / 6)
    rotate_y(PI / 6)

    # Set the title
    text_align(CENTER)
    text('Solar System', 0, -300, 0)
  end

  def create_dataframe(data)
    require 'pandas'

    pd = Pandas::DataFrame
    pd.new(data)
  end

  def draw_planet(x, y, z, size, color)
    push_matrix
    translate(x * 100, y * 100, z * 100)
    fill(color)
    sphere(size)
    pop_matrix
  end
end

SolarSystemSketch.new(title: 'Solar System', width: 800, height: 800)
