# Size of the 2D matrix (N x N)
# grid_size = N / means N = 9
grid_size = 9  

# A utility function to print the grid
def print_grid(grid)
  grid.each do |row|
    row.each do |col|
      print "#{col} "
    end
    puts
  end
end

# Checks whether it will be legal to assign num to the given row, col
def is_safe(grid, row, col, num)
  # Check if we find the same num in the same row, return false
  grid[row].each do |check_col|
    return false if check_col == num
  end

  # Check if we find the same num in the same column, return false
  grid.each do |check_row|
    return false if check_row[col] == num
  end

  # Check if we find the same num in the particular 3x3 matrix, return false
  start_row = row - row % 3
  start_col = col - col % 3
  (0..2).each do |check_row|
    (0..2).each do |check_col|
      return false if grid[check_row + start_row][check_col + start_col] == num
    end
  end
  true
end

# Takes a partially filled-in grid and attempts to assign values to all unassigned locations
def solve_sudoku(grid, row, col)
  # Check if we have reached the last row and column, return true to avoid further backtracking
  if row == grid_size - 1 && col == grid_size
    return true
  end

  # Check if column value becomes grid_size, move to the next row and column start from 0
  if col == grid_size
    row += 1
    col = 0
  end

  # Check if the current position of the grid already contains a value > 0, iterate for the next column
  if grid[row][col] > 0
    return solve_sudoku(grid, row, col + 1)
  end

  (1..grid_size).each do |num|
    # Check if it is safe to place the num (1-9) in the given row, col
    if is_safe(grid, row, col, num)
      # Assign the num in the current (row, col) position of the grid and assume it is correct
      grid[row][col] = num

      # Check for the next possibility with the next column
      if solve_sudoku(grid, row, col + 1)
        return true
      end

      # If the assumption was wrong, remove the assigned num and go for the next assumption with a different num value
      grid[row][col] = 0
    end
  end

  false
end

# Driver Code
# 0 means unassigned cells
grid = [
  [3, 0, 6, 5, 0, 8, 4, 0, 0],
  [5, 2, 0, 0, 0, 0, 0, 0, 0],
  [0, 8, 7, 0, 0, 0, 0, 3, 1],
  [0, 0, 3, 0, 1, 0, 0, 8, 0],
  [9, 0, 0, 8, 6, 3, 0, 0, 5],
  [0, 5, 0, 0, 9, 0, 6, 0, 0],
  [1, 3, 0, 0, 0, 0, 2, 5, 0],
  [0, 0, 0, 0, 0, 0, 0, 7, 4],
  [0, 0, 5, 2, 0, 6, 3, 0, 0]
]

if solve_sudoku(grid, 0, 0)
  print_grid(grid)
else
  puts "No solution exists."
end
