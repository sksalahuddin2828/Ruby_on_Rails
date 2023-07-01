# This code uses the rubyplot gem to create a 3D scatter plot. To run this code, make sure you have the rubyplot gem installed (gem install rubyplot)

require 'rubyplot'

# Define the coordinates and sizes of the celestial bodies
bodies = {
  "Sun" => [0, 0, 0, 20],
  "Mercury" => [50, 0, 0, 5],
  "Venus" => [70, 0, 0, 7],
  "Earth" => [100, 0, 0, 7],
  "Mars" => [150, 0, 0, 6],
  "Jupiter" => [220, 0, 0, 18],
  "Saturn" => [280, 0, 0, 15],
  "Uranus" => [350, 0, 0, 12],
  "Neptune" => [400, 0, 0, 12]
}

# Create a new 3D plot
plot = Rubyplot::Plot3d.new

# Set the labels
plot.x_label = "X"
plot.y_label = "Y"
plot.z_label = "Z"

# Plot each body as a sphere
bodies.each do |body, (x, y, z, size)|
  plot.data(body, [[x, y, z, size]], Rubyplot::Scatter3d)
end

# Set the aspect ratio
plot.x_axis_scale = 1
plot.y_axis_scale = 1
plot.z_axis_scale = 1

# Show the plot
plot.render("solar_system.png")
