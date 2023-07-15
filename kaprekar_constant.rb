def kaprekar_constant(n)
  count = 0
  while n != 6174
    count += 1
    digits = n.to_s.rjust(4, '0').chars
    ascending = digits.sort.join.to_i
    descending = digits.sort.reverse.join.to_i
    n = descending - ascending
  end
  count
end

puts "Enter a number:"
user_input = gets.chomp.to_i
steps = kaprekar_constant(user_input)
puts "Number of steps to reach Kaprekar constant: #{steps}"

#-----------------------------------------------------------------------------

def kaprekar_constant(n)
  count = 0
  while n != 6174
    count += 1
    digits = n.to_s.rjust(4, '0').chars
    ascending = digits.sort.join.to_i
    descending = digits.sort.reverse.join.to_i
    n = descending - ascending
  end
  count
end

puts kaprekar_constant(1234)  

# Output: 3
