# To run this code, make sure you have the ruby-processing gem installed (gem install ruby-processing).

require 'ruby-processing'

class EarthRotationSketch < Processing::App
  def setup
    size(800, 800)
    background(255)
    @frame = 0
    @map = nil
    frame_rate(60)
    no_loop
  end

  def draw
    background(255)
    @map = create_map unless @map
    draw_map(@frame)
    @frame += 2
    @frame = 0 if @frame >= 360
  end

  def create_map
    Basemap.new(self)
  end

  def draw_map(frame)
    @map.lon_0 = frame
    @map.draw_coastlines(color: color(128))
    @map.bluemarble
    text('3D Earth Rotation', 10, height - 20)
  end
end

class Basemap
  attr_accessor :app, :lon_0

  def initialize(app)
    @app = app
    @lon_0 = 0
  end

  def draw_coastlines(options = {})
    app.stroke(options[:color])
    app.no_fill
    # draw coastlines logic goes here
  end

  def bluemarble
    # display the Blue Marble image logic goes here
  end
end

EarthRotationSketch.new(title: '3D Earth Rotation', width: 800, height: 800)
