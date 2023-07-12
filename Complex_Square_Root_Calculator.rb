print 'Enter a number: '
num = gets.chomp.to_f

# Find the square root of the number
real_part = Math.sqrt(num.abs)
imaginary_part = Math.sqrt(-num)

# Display the result
if imaginary_part == 0
  puts "The square root of #{num} is #{'%.3f' % real_part}"
else
  puts "The square root of #{num} is #{'%.3f' % real_part}+#{'%.3f' % imaginary_part}i"
end
