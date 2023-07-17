require 'numpy'
require 'matplotlib/pyplot' as plt

# Define tesseract vertices
vertices = Numpy.array([[-1, -1, -1, -1],
                       [-1, -1, -1,  1],
                       [-1, -1,  1, -1],
                       [-1, -1,  1,  1],
                       [-1,  1, -1, -1],
                       [-1,  1, -1,  1],
                       [-1,  1,  1, -1],
                       [-1,  1,  1,  1],
                       [ 1, -1, -1, -1],
                       [ 1, -1, -1,  1],
                       [ 1, -1,  1, -1],
                       [ 1, -1,  1,  1],
                       [ 1,  1, -1, -1],
                       [ 1,  1, -1,  1],
                       [ 1,  1,  1, -1],
                       [ 1,  1,  1,  1]])

# Define edges of the tesseract
edges = [[0, 1], [0, 2], [0, 4], [1, 3], [1, 5], [2, 3], [2, 6], [3, 7],
         [4, 5], [4, 6], [5, 7], [6, 7], [8, 9], [8, 10], [8, 12], [9, 11],
         [9, 13], [10, 11], [10, 14], [11, 15], [12, 13], [12, 14], [13, 15],
         [14, 15], [0, 8], [1, 9], [2, 10], [3, 11], [4, 12], [5, 13], [6, 14],
         [7, 15]]

# Create a figure and axis
fig = plt.figure(figsize: [8, 8])
ax = fig.add_subplot(111, projection: '3d')
ax.set_aspect('auto')
ax.axis('off')

# Plot the tesseract edges
edges.each do |edge|
    ax.plot3D(vertices[edge[0]], vertices[edge[1]], color: 'black')
end

# Define rotation matrix
angle = Math::PI / 4
rotation_matrix = Numpy.array([[Math.cos(angle), 0, -Math.sin(angle), 0],
                               [0, Math.cos(angle), 0, -Math.sin(angle)],
                               [Math.sin(angle), 0, Math.cos(angle), 0],
                               [0, Math.sin(angle), 0, Math.cos(angle)]])

# Project vertices onto 3D space
projected_vertices = Numpy.dot(vertices, rotation_matrix)

# Plot projected vertices with labels
labels = vertices.map { |vertex| vertex.join('') }
sc = ax.scatter(projected_vertices[:, 0], projected_vertices[:, 1], projected_vertices[:, 2],
                s: 100, c: vertices[:, 3], cmap: 'viridis')
labels.each_with_index do |label, i|
    ax.text(projected_vertices[i, 0], projected_vertices[i, 1], projected_vertices[i, 2],
            label, fontsize: 8, ha: 'center', va: 'center')
end

# Create illusion lines connecting projected vertices
(0...projected_vertices.length).each do |i|
    ((i + 1)...projected_vertices.length).each do |j|
        ax.plot([projected_vertices[i, 0], projected_vertices[j, 0]],
                [projected_vertices[i, 1], projected_vertices[j, 1]],
                [projected_vertices[i, 2], projected_vertices[j, 2]], 'k--', alpha: 0.3)
    end
end

# Add a color bar
cbar = fig.colorbar(sc, ax: ax, shrink: 0.8)
cbar.set_label('Fourth Dimension')

# Display the plot
plt.show()
