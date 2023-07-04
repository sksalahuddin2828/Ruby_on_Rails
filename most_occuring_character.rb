def find_most_occ_char(string)
  char_count = Hash.new(0)

  # Count the occurrence of each character in the string
  string.each_char { |c| char_count[c] += 1 }

  max_count = char_count.values.max

  # Collect the most occurring character(s)
  most_occ_chars = char_count.select { |_char, count| count == max_count }.keys

  # Printing the most occurring character(s) and its count
  most_occ_chars.each do |char|
    puts "Character: #{char}, Count: #{max_count}"
  end
end

# Driver program
input_string = 'helloworldmylovelypython'
find_most_occ_char(input_string)
