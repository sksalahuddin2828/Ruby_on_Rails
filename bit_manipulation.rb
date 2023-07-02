array = [1, 2, 3, 4]
length = 1 << array.length

(0...length).each do |var|
  number = var
  position = 0
  store_array = []
  
  while number != 0
    if number & (1 << 0) != 0
      store_array << array[position]
    end
    number = number >> 1
    position = position + 1
  end
  
  puts store_array.inspect
end
