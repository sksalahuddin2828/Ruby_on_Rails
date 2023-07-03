def calculate_factorial(n)
  if n > 1
    n * calculate_factorial(n - 1)
  else
    1
  end
end

print "Enter a non-negative number: "
number = gets.chomp.to_i
result = calculate_factorial(number)
puts "Factorial of #{number} = #{result}"
