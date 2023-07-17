# Please must need to have the numpy and matplotlib gems installed to run this code.

require 'numpy'
require 'matplotlib/pyplot'

# Define tesseract vertices
vertices = Numpy.array([
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
])

# Define edges of the tesseract
edges = [
  [0, 1], [0, 2], [0, 4], [1, 3], [1, 5], [2, 3], [2, 6], [3, 7],
  [4, 5], [4, 6], [5, 7], [6, 7], [8, 9], [8, 10], [8, 12], [9, 11],
  [9, 13], [10, 11], [10, 14], [11, 15], [12, 13], [12, 14], [13, 15],
  [14, 15], [0, 8], [1, 9], [2, 10], [3, 11], [4, 12], [5, 13], [6, 14],
  [7, 15]
]

# Create a figure and axis
fig = Matplotlib::Pyplot.figure(figsize: [8, 8])
ax = fig.add_subplot(111, projection: '3d')
ax.set_aspect('auto')
ax.axis('off')

# Project vertices onto 3D space (select the first three components)
projected_vertices = vertices[true, 0...3]

# Plot the tesseract edges
edges.each do |edge|
  ax.plot3D(
    projected_vertices[edge[0], 0..1].tolist,
    projected_vertices[edge[0], 0..1].tolist,
    projected_vertices[edge[0], 0..1].tolist,
    color: 'gray', linestyle: 'dashed', linewidth: 1
  )
end

# Plot projected vertices with labels
projected_vertices.each_with_index do |vertex, i|
  ax.text(*vertex, s: i.to_s, fontsize: 8, ha: 'center', va: 'center')
end

# Create illusion lines connecting projected vertices
projected_vertices.each_with_index do |vertex1, i|
  projected_vertices[(i + 1)..].each do |vertex2|
    ax.plot(
      [vertex1[0], vertex2[0]],
      [vertex1[1], vertex2[1]],
      [vertex1[2], vertex2[2]],
      'k--', alpha: 0.3
    )
  end
end

# Add a title and description
ax.set_title('3D Projection of a Tesseract (4D Hypercube)')
ax.text2D(
  0.05, 0.95,
  'A tesseract is a 4D hypercube represented in 3D space using perspective projection.\n' \
  'The color coding represents the variation of the fifth dimension (w).',
  transform: ax.transAxes, fontsize: 10
)

# Display the plot
Matplotlib::Pyplot.show()
