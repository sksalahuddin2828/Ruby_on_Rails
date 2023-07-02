print "Enter your height in centimeters: "
height = gets.chomp.to_f

print "Enter your weight in Kg: "
weight = gets.chomp.to_f

height = height / 100
bmi = weight / (height * height)

puts "Your Body-Mass index is: %.2f" % bmi

if bmi > 0
  if bmi <= 16
    puts "You are severely under-weight."
  elsif bmi <= 18.5
    puts "You are under-weight."
  elsif bmi <= 25
    puts "You are Healthy."
  elsif bmi <= 30
    puts "You are overweight."
  else
    puts "You are severely overweight."
  end
else
  puts "Please enter valid details."
end
