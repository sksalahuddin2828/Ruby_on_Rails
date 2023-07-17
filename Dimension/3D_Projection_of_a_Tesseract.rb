# gem install ruby2d

require 'ruby2d'

# Define tesseract vertices
vertices = [
  [-1, -1, -1, -1, -1],
  [-1, -1, -1, -1, 1],
  [-1, -1, -1, 1, -1],
  [-1, -1, -1, 1, 1],
  [-1, -1, 1, -1, -1],
  [-1, -1, 1, -1, 1],
  [-1, -1, 1, 1, -1],
  [-1, -1, 1, 1, 1],
  [-1, 1, -1, -1, -1],
  [-1, 1, -1, -1, 1],
  [-1, 1, -1, 1, -1],
  [-1, 1, -1, 1, 1],
  [-1, 1, 1, -1, -1],
  [-1, 1, 1, -1, 1],
  [-1, 1, 1, 1, -1],
  [-1, 1, 1, 1, 1],
  [1, 1, 1, 1, 1] # Second dimension vertex
]

# Define edges of the tesseract
edges = [
  [0, 1], [0, 2], [0, 4], [1, 3], [1, 5], [2, 3], [2, 6], [3, 7],
  [4, 5], [4, 6], [5, 7], [6, 7], [8, 9], [8, 10], [8, 12], [9, 11],
  [9, 13], [10, 11], [10, 14], [11, 15], [12, 13], [12, 14], [13, 15],
  [14, 15], [0, 8], [1, 9], [2, 10], [3, 11], [4, 12], [5, 13], [6, 14],
  [7, 15]
]

# Create the window
set(title: '3D Projection of a Tesseract (4D Hypercube)', width: 800, height: 800)

update do
  clear

  # Move the camera back
  translate(0, 0, -10)

  # Draw the tesseract edges
  vertices.each do |vertex|
    edges.each do |edge|
      x1, y1, z1 = vertex
      x2, y2, z2 = vertices[edge[1]]
      Line.new(x1: x1, y1: y1, x2: x2, y2: y2, width: 1, color: 'gray', z: z1 + z2)
    end
  end

  # Draw projected vertices with labels
  vertices.each_with_index do |vertex, i|
    x, y, z = vertex
    Text.new(i.to_s, x: x, y: y, size: 8, color: 'black', z: z + 1)
  end
end

show
