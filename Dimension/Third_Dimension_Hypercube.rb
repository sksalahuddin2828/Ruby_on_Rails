require 'narray'
require 'numo/gnuplot'

def generate_hypercube_edges(dimensions)
  num_vertices = 2 ** dimensions
  gray_codes = (0...num_vertices).map { |i| i ^ (i >> 1) }
  edges = []
  (0...num_vertices).each do |i|
    (0...dimensions).each do |j|
      neighbor = i ^ (1 << j)
      if gray_codes[i] < gray_codes[neighbor]
        edges << [i, neighbor]
      end
    end
  end
  edges
end

# Define the number of dimensions for the hypercube
num_dimensions = 5

# Generate hypercube edges
edges = generate_hypercube_edges(num_dimensions)

# Generate hypercube vertices
num_vertices = 2 ** num_dimensions
vertices = (0...num_vertices).map do |vertex|
  (0...num_dimensions).map { |i| (vertex >> i) & 1 == 1 ? -1 : 1 }
end

# Define rotation matrices for different dimensions
angles = (0...(num_dimensions + 1)).map { |i| 2 * Math::PI * i / num_dimensions }[0...-1]
rotation_matrices = angles.map do |angle|
  [
    [Math.cos(angle), -Math.sin(angle), 0],
    [Math.sin(angle), Math.cos(angle), 0],
    [0, 0, 1]
  ]
end

# Apply rotations to the vertices
projected_vertices = vertices.map { |v| v.take(3) }
(num_dimensions - 3).times do |i|
  projected_vertices = projected_vertices.map { |v| v.dot(rotation_matrices[i + 3]) }
end

# Add random offsets to each vertex
offsets = Numo::DFloat.new(num_vertices, 3).rand(-0.2..0.2)
projected_vertices = projected_vertices.zip(offsets).map { |v, o| v + o }

# Create a plot
Numo.gnuplot do
  set view: [45, 45]
  set title: 'Hypercube Projection'
  set xlabel: 'X'
  set ylabel: 'Y'
  set zlabel: 'Z'
  set xrange: -1.5..1.5
  set yrange: -1.5..1.5
  set zrange: -1.5..1.5
  unset :xtics
  unset :ytics
  unset :ztics

  # Plot the hypercube edges with modified transparency and linewidth
  edges.each do |edge|
    vertices = edge.map do |vertex|
      (0...num_dimensions).map { |i| (vertex >> i) & 1 == 1 ? -1 : 1 }
    end
    splot [vertices, with: 'lines', lt: 1, lc: 'red', lw: 2, notitle: true]
  end

  # Plot projected vertices with labels
  projected_vertices.each_with_index do |v, i|
    label = (0...num_dimensions).map { |j| v[j] > 0 ? '1' : '0' }.join('')
    splot [[v], with: 'points', pt: 7, ps: 2, lc: 'viridis', notitle: true]
    set label: label, at: v[0..1], center: true, font: '"Arial,8"'
  end

  # Create illusion lines connecting projected vertices in 3D space
  (0...num_vertices).each do |i|
    ((i + 1)...num_vertices).each do |j|
      splot [[projected_vertices[i], projected_vertices[j]], with: 'lines', lt: 0, lc: 'black', lw: 1, notitle: true]
    end
  end

  # Add a color bar for the third dimension
  set :cblabel, 'Third Dimension'
  unset :colorbox

  pause mouse: ''
end
