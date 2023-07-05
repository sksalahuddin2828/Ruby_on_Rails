# Program for checking voter age

print "Enter your age: "
age = gets.chomp.to_i

# Check if the age is within a valid range for voting
if (18..120).include?(age)
    puts "Congratulations!"
    puts "You are eligible to vote."
elsif (12...18).include?(age)
    puts "You are not yet eligible to vote."
    puts "Enjoy your teenage years!"
elsif (0...12).include?(age)
    puts "You are too young to vote."
    puts "Make the most of your childhood!"
elsif age < 0
    puts "Invalid age entered."
    puts "Please enter a positive value."
else
    puts "You have surpassed the maximum voting age."
    puts "Thank you for your contribution to society!"
end
