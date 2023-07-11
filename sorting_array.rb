def are_arrays_equal(array1, array2)
  length1 = array1.length
  length2 = array2.length

  return false if length1 != length2

  # Sort both arrays
  array1.sort!
  array2.sort!

  # Linearly compare elements
  (0...length1).each do |i|
    return false if array1[i] != array2[i]
  end

  # If all elements are the same
  true
end

array1 = [3, 5, 2, 5, 2]
array2 = [2, 3, 5, 5, 2]

if are_arrays_equal(array1, array2)
  puts "The arrays are equal"
else
  puts "The arrays are not equal"
end
