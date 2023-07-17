# gem install rubyplot

require 'rubyplot'

def tesseract_projection
  # Define the vertices of a unit tesseract in 4D space
  vertices = [
    [-0.5, -0.5, -0.5, -0.5],
    [0.5, -0.5, -0.5, -0.5],
    [0.5, 0.5, -0.5, -0.5],
    [-0.5, 0.5, -0.5, -0.5],
    [-0.5, -0.5, 0.5, -0.5],
    [0.5, -0.5, 0.5, -0.5],
    [0.5, 0.5, 0.5, -0.5],
    [-0.5, 0.5, 0.5, -0.5],
    [-0.5, -0.5, -0.5, 0.5],
    [0.5, -0.5, -0.5, 0.5],
    [0.5, 0.5, -0.5, 0.5],
    [-0.5, 0.5, -0.5, 0.5],
    [-0.5, -0.5, 0.5, 0.5],
    [0.5, -0.5, 0.5, 0.5],
    [0.5, 0.5, 0.5, 0.5],
    [-0.5, 0.5, 0.5, 0.5]
  ]

  # Define the edges of the tesseract
  edges = [
    [0, 1], [1, 2], [2, 3], [3, 0],
    [4, 5], [5, 6], [6, 7], [7, 4],
    [0, 4], [1, 5], [2, 6], [3, 7],
    [8, 9], [9, 10], [10, 11], [11, 8],
    [12, 13], [13, 14], [14, 15], [15, 12],
    [8, 12], [9, 13], [10, 14], [11, 15],
    [0, 8], [1, 9], [2, 10], [3, 11],
    [4, 12], [5, 13], [6, 14], [7, 15]
  ]

  # Initialize the plot
  plot = Rubyplot::Scatter.new

  # Project the tesseract's vertices to 3D space
  projection_3d = vertices.map { |v| [(v[0] + v[1]) / 2.0, (v[2] + v[3]) / 2.0, (v[0] + v[2]) / 2.0] }

  # Plot the edges
  edges.each do |edge|
    x_values = [projection_3d[edge[0]][0], projection_3d[edge[1]][0]]
    y_values = [projection_3d[edge[0]][1], projection_3d[edge[1]][1]]
    z_values = [projection_3d[edge[0]][2], projection_3d[edge[1]][2]]
    plot.data 'Edge', x_values, y_values, z_values, marker_color: :blue, marker_size: 3
  end

  # Show the plot
  plot.write('tesseract_projection.png')
end

tesseract_projection
