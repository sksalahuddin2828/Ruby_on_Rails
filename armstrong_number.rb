def is_armstrong_number(n)
  num_digits = n.to_s.length
  sum_of_powers = 0
  temp = n
  while temp > 0
    digit = temp % 10
    sum_of_powers += digit**num_digits
    temp /= 10
  end
  n == sum_of_powers
end

puts "Enter a number:"
user_input = gets.chomp.to_i
if is_armstrong_number(user_input)
  puts "#{user_input} is an Armstrong number."
else
  puts "#{user_input} is not an Armstrong number."
end

#------------------------------------------------------------------

def is_armstrong_number(n)
  num_digits = n.to_s.length
  sum_of_powers = 0
  temp = n
  while temp > 0
    digit = temp % 10
    sum_of_powers += digit**num_digits
    temp /= 10
  end
  n == sum_of_powers
end

puts is_armstrong_number(153)  

# Output: true
