#----------------------------------------------------------------Ruby Coding Challenges--------------------------------------------------------

# Ruby Coding Challenges on Numbers 
# Write a program in Ruby to -

# 1. Convert decimal numbers to octal numbers.
# 2. Reverse an integer.
# 3. Print the Fibonacci series using the recursive method.
# 4. Return the Nth value from the Fibonacci sequence.
# 5. Find the average of numbers (with explanations).
# 6. Convert Celsius to Fahrenheit.

#----------------------------------------------------------------Solution of Problem:----------------------------------------------------------

# 1. Converting Decimal Numbers to Octal Numbers:

decimal_number = 25
octal_number = []

while decimal_number > 0
  octal_number.push(decimal_number % 8)
  decimal_number /= 8
end

print "Octal number: "
octal_number.reverse_each { |digit| print digit }

#----------------------------------------------------------------------------------------------------------------------------------------------

# 2. Reversing an Integer:

number = 12345
reversed_number = 0

while number != 0
  reversed_number = reversed_number * 10 + number % 10
  number /= 10
end

puts reversed_number

#----------------------------------------------------------------------------------------------------------------------------------------------

# 3. Printing the Fibonacci Series using Recursion:

def fibonacci(n)
  return n if n <= 1

  fibonacci(n - 1) + fibonacci(n - 2)
end

n = 10
print "Fibonacci series: "
(0...n).each { |i| print fibonacci(i).to_s + " " }

#----------------------------------------------------------------------------------------------------------------------------------------------

# 4. Returning the Nth Value from the Fibonacci Sequence:

def fibonacci(n)
  return n if n <= 1

  fibonacci(n - 1) + fibonacci(n - 2)
end

n = 10
fibonacci_number = fibonacci(n)
puts fibonacci_number

#----------------------------------------------------------------------------------------------------------------------------------------------

# 5. Finding the Average of Numbers:

numbers = [10, 20, 30, 40, 50]
average = numbers.sum.to_f / numbers.length
puts "Average: #{average}"
