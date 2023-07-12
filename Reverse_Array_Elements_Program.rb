print 'Please enter the total number you want to enter: '
number = gets.chomp.to_i

array = []
number.times do |i|
    print "Enter the element #{i + 1}: "
    array << gets.chomp.to_i
end

(number / 2).times do |i|
    temp = array[i]
    array[i] = array[number - 1 - i]
    array[number - 1 - i] = temp
end

puts "\nReverse all elements of the array:"
array.each do |element|
    puts element
end
