require 'opengl'
require 'glu'
require 'glut'
require 'orekit'

include Gl
include Glu
include Glut
include Orekit

# Define satellite data class
class SatelliteData
  attr_accessor :name, :line1, :line2, :color
end

satellite_data_list = []

def read_tle_data(tle_file)
  File.open(tle_file, 'r') do |file|
    lines = file.readlines
    lines.each_slice(3) do |slice|
      satellite_data = SatelliteData.new
      satellite_data.name = slice[0].strip
      satellite_data.line1 = slice[1].strip
      satellite_data.line2 = slice[2].strip
      satellite_data.color = [0.0, 0.0, 0.0] # Set default color to black
      satellite_data_list << satellite_data
    end
  end
end

def draw_sphere(radius, slices, stacks)
  quadric = gluNewQuadric
  gluSphere(quadric, radius, slices, stacks)
  gluDeleteQuadric(quadric)
end

def draw_cylinder(base, top, height, slices, stacks)
  quadric = gluNewQuadric
  gluCylinder(quadric, base, top, height, slices, stacks)
  gluDeleteQuadric(quadric)
end

def render_scene
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
  glLoadIdentity

  # Draw Earth
  glColor3f(0.0, 0.0, 1.0)
  draw_sphere(1.0, 32, 32)

  # Draw satellite paths
  satellite_data_list.each do |satellite_data|
    glColor3fv(satellite_data.color)

    tle = TLE.new('', satellite_data.line1, satellite_data.line2)
    orbit = tle.orbit
    t = 0.0
    dt = 5.0
    glBegin(GL_LINE_STRIP)
    72.times do
      date = AbsoluteDate.new_j2000_epoch.shiftedBy(t)
      pv_coordinates = orbit.getPVCoordinates(date)
      x = pv_coordinates.getPosition.getX / 1000.0
      y = pv_coordinates.getPosition.getY / 1000.0
      z = pv_coordinates.getPosition.getZ / 1000.0
      glVertex3d(x, y, z)
      t += dt
    end
    glEnd
  end

  glFlush
  glutSwapBuffers
end

def reshape(width, height)
  glViewport(0, 0, width, height)
  glMatrixMode(GL_PROJECTION)
  glLoadIdentity
  gluPerspective(45.0, width.to_f / height.to_f, 0.1, 100.0)
  glMatrixMode(GL_MODELVIEW)
end

def init_gl
  glClearColor(0.0, 0.0, 0.0, 1.0)
  glEnable(GL_DEPTH_TEST)
  glDepthFunc(GL_LEQUAL)
  glShadeModel(GL_SMOOTH)
  glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST)
end

# Initialize Orekit
Orekit.init

# Read TLE data from a file
tle_file = 'tle_data.txt' # Path to the TLE file
read_tle_data(tle_file)

# Initialize GLUT
glutInit
glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH)
glutInitWindowSize(800, 600)
glutCreateWindow('Satellite Orbits')

# Set GLUT callbacks
glutDisplayFunc(method(:render_scene).to_proc)
glutReshapeFunc(method(:reshape).to_proc)

# Initialize OpenGL
init_gl

# Start the main GLUT loop
glutMainLoop

# Cleanup
Orekit::shutdown
