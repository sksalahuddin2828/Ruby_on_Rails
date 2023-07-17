# Please you have the narray and gnuplot gems installed before running this code. The code uses the narray gem for array operations and the gnuplot gem for plotting.

require 'rubygems'
require 'narray'
require 'gnuplot'

# Define tesseract vertices
vertices = NArray[[-1, -1, -1, -1, -1],
                  [-1, -1, -1, -1,  1],
                  [-1, -1, -1,  1, -1],
                  [-1, -1, -1,  1,  1],
                  [-1, -1,  1, -1, -1],
                  [-1, -1,  1, -1,  1],
                  [-1, -1,  1,  1, -1],
                  [-1, -1,  1,  1,  1],
                  [-1,  1, -1, -1, -1],
                  [-1,  1, -1, -1,  1],
                  [-1,  1, -1,  1, -1],
                  [-1,  1, -1,  1,  1],
                  [-1,  1,  1, -1, -1],
                  [-1,  1,  1, -1,  1],
                  [-1,  1,  1,  1, -1],
                  [-1,  1,  1,  1,  1],
                  [ 1, -1, -1, -1, -1],
                  [ 1, -1, -1, -1,  1],
                  [ 1, -1, -1,  1, -1],
                  [ 1, -1, -1,  1,  1],
                  [ 1, -1,  1, -1, -1],
                  [ 1, -1,  1, -1,  1],
                  [ 1, -1,  1,  1, -1],
                  [ 1, -1,  1,  1,  1],
                  [ 1,  1, -1, -1, -1],
                  [ 1,  1, -1, -1,  1],
                  [ 1,  1, -1,  1, -1],
                  [ 1,  1, -1,  1,  1],
                  [ 1,  1,  1, -1, -1],
                  [ 1,  1,  1, -1,  1],
                  [ 1,  1,  1,  1, -1],
                  [ 1,  1,  1,  1,  1]]

# Define edges of the tesseract
edges = [[0, 1], [0, 2], [0, 4], [1, 3], [1, 5], [2, 3], [2, 6], [3, 7],
         [4, 5], [4, 6], [5, 7], [6, 7], [8, 9], [8, 10], [8, 12], [9, 11],
         [9, 13], [10, 11], [10, 14], [11, 15], [12, 13], [12, 14], [13, 15],
         [14, 15], [0, 8], [1, 9], [2, 10], [3, 11], [4, 12], [5, 13], [6, 14],
         [7, 15]]

# Plot the tesseract edges
Gnuplot.open do |gp|
  Gnuplot::Plot.new(gp) do |plot|
    plot.set('isosamples', '40')
    plot.set('hidden3d')
    plot.set('nokey')
    plot.set('border', '')
    plot.set('tics', '')
    plot.set('noxtics')
    plot.set('noytics')
    plot.set('noztics')
    plot.set('xtics', '')
    plot.set('ytics', '')
    plot.set('ztics', '')
    plot.set('view', '50, 135')
    plot.set('xlabel', '')
    plot.set('ylabel', '')
    plot.set('zlabel', '')

    edges.each do |edge|
      x = [vertices[edge[0]][0], vertices[edge[1]][0]]
      y = [vertices[edge[0]][1], vertices[edge[1]][1]]
      z = [vertices[edge[0]][2], vertices[edge[1]][2]]
      plot.data << Gnuplot::DataSet.new([x, y, z]) do |ds|
        ds.with = 'lines'
        ds.linewidth = 2
        ds.linecolor = 'black'
      end
    end

    # Define rotation matrix
    angle = Math::PI / 4
    rotation_matrix = NArray[[Math.cos(angle), 0, -Math.sin(angle), 0, 0],
                             [0, Math.cos(angle), 0, -Math.sin(angle), 0],
                             [Math.sin(angle), 0, Math.cos(angle), 0, 0],
                             [0, Math.sin(angle), 0, Math.cos(angle), 0],
                             [0, 0, 0, 0, 1]]

    # Project vertices onto 3D space
    projected_vertices = vertices.dot(rotation_matrix[0..2, 0..2])

    # Plot projected vertices with labels
    labels = vertices.map { |vertex| vertex.join }
    plot.data << Gnuplot::DataSet.new([projected_vertices[true, 0],
                                       projected_vertices[true, 1],
                                       projected_vertices[true, 2],
                                       labels]) do |ds|
      ds.with = 'points'
      ds.pointsize = 2
      ds.linecolor = 'black'
      ds.title = 'Fifth Dimension'
      ds.using = '1:2:3:(sprintf("%s", $4))'
    end

    # Create illusion lines connecting projected vertices
    (0...projected_vertices.shape[0]).each do |i|
      ((i + 1)...projected_vertices.shape[0]).each do |j|
        x = [projected_vertices[i, 0], projected_vertices[j, 0]]
        y = [projected_vertices[i, 1], projected_vertices[j, 1]]
        z = [projected_vertices[i, 2], projected_vertices[j, 2]]
        plot.data << Gnuplot::DataSet.new([x, y, z]) do |ds|
          ds.with = 'lines'
          ds.linewidth = 0.5
          ds.linecolor = 'black'
          ds.linetype = 1
          ds.dashtype = 2
        end
      end
    end
  end
end
