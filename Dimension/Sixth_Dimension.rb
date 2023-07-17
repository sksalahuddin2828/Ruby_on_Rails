# Please make sure you have the nmatrix and matplotlib gems installed in your Ruby environment.

require 'nmatrix'
require 'matplotlib/pyplot'

# Define tesseract vertices with the sixth dimension
vertices = NMatrix[
  [-1, -1, -1, -1, -1, -1],
  [-1, -1, -1, -1, -1,  1],
  [-1, -1, -1, -1,  1, -1],
  [-1, -1, -1, -1,  1,  1],
  [-1, -1, -1,  1, -1, -1],
  [-1, -1, -1,  1, -1,  1],
  [-1, -1, -1,  1,  1, -1],
  [-1, -1, -1,  1,  1,  1],
  [-1,  1, -1, -1, -1, -1],
  [-1,  1, -1, -1, -1,  1],
  [-1,  1, -1, -1,  1, -1],
  [-1,  1, -1, -1,  1,  1],
  [-1,  1,  1, -1, -1, -1],
  [-1,  1,  1, -1, -1,  1],
  [-1,  1,  1, -1,  1, -1],
  [-1,  1,  1, -1,  1,  1],
  [ 1, -1, -1, -1, -1, -1],
  [ 1, -1, -1, -1, -1,  1],
  [ 1, -1, -1, -1,  1, -1],
  [ 1, -1, -1, -1,  1,  1],
  [ 1, -1,  1, -1, -1, -1],
  [ 1, -1,  1, -1, -1,  1],
  [ 1, -1,  1, -1,  1, -1],
  [ 1, -1,  1, -1,  1,  1],
  [ 1,  1, -1, -1, -1, -1],
  [ 1,  1, -1, -1, -1,  1],
  [ 1,  1, -1, -1,  1, -1],
  [ 1,  1, -1, -1,  1,  1],
  [ 1,  1,  1, -1, -1, -1],
  [ 1,  1,  1, -1, -1,  1],
  [ 1,  1,  1, -1,  1, -1],
  [ 1,  1,  1, -1,  1,  1]
]

# Define edges of the tesseract
edges = [
  [0, 1], [0, 2], [0, 4], [1, 3], [1, 5], [2, 3], [2, 6], [3, 7],
  [4, 5], [4, 6], [5, 7], [6, 7], [8, 9], [8, 10], [8, 12], [9, 11],
  [9, 13], [10, 11], [10, 14], [11, 15], [12, 13], [12, 14], [13, 15],
  [14, 15], [0, 8], [1, 9], [2, 10], [3, 11], [4, 12], [5, 13], [6, 14],
  [7, 15]
]

# Create a figure and axis
fig, ax = Matplotlib::Pyplot.subplots(subplot_kw: { projection: '3d' })
ax.set_aspect('auto')
ax.axis('off')

# Plot the tesseract edges
edges.each do |edge|
  x = [vertices[edge[0]][0], vertices[edge[1]][0]]
  y = [vertices[edge[0]][1], vertices[edge[1]][1]]
  z = [vertices[edge[0]][2], vertices[edge[1]][2]]
  ax.plot3D(x, y, z, color: 'black')
end

# Define rotation matrix for the first three dimensions
angle = Math::PI / 4
rotation_matrix_3d = NMatrix[
  [Math.cos(angle), 0, -Math.sin(angle)],
  [0, Math.cos(angle), 0],
  [Math.sin(angle), 0, Math.cos(angle)]
]

# Project vertices onto 3D space
projected_vertices_3d = vertices[0...vertices.shape[0], 0...3].dot(rotation_matrix_3d)

# Define rotation matrix for the fourth, fifth, and sixth dimensions
rotation_matrix_456 = NMatrix[
  [1, 0, 0],
  [0, Math.cos(angle), -Math.sin(angle)],
  [0, Math.sin(angle), Math.cos(angle)]
]

# Project vertices from 3D space to the fourth, fifth, and sixth dimensions
projected_vertices_456 = projected_vertices_3d.dot(rotation_matrix_456)

# Plot projected vertices with labels
labels = vertices.to_a.map { |vertex| vertex.join('') }
sc = ax.scatter(projected_vertices_3d[0...projected_vertices_3d.shape[0], 0],
                projected_vertices_3d[0...projected_vertices_3d.shape[0], 1],
                projected_vertices_3d[0...projected_vertices_3d.shape[0], 2],
                s: 100, c: projected_vertices_456[0...projected_vertices_456.shape[0], 2], cmap: 'viridis')
vertices.shape[0].times do |i|
  ax.text(projected_vertices_3d[i, 0], projected_vertices_3d[i, 1], projected_vertices_3d[i, 2],
          labels[i], fontsize: 8, ha: 'center', va: 'center')
end

# Create illusion lines connecting projected vertices in 3D space
projected_vertices_3d.shape[0].times do |i|
  (i + 1).upto(projected_vertices_3d.shape[0] - 1) do |j|
    ax.plot([projected_vertices_3d[i, 0], projected_vertices_3d[j, 0]],
            [projected_vertices_3d[i, 1], projected_vertices_3d[j, 1]],
            [projected_vertices_3d[i, 2], projected_vertices_3d[j, 2]], 'k--', alpha: 0.3)
  end
end

# Add a color bar for the sixth dimension
cbar = fig.colorbar(sc, ax: ax, shrink: 0.8)
cbar.set_label('Sixth Dimension')

# Display the plot
Matplotlib::Pyplot.show
