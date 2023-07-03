class Complex
  attr_accessor :real, :imag
  
  def set_data
    print "Enter the real value of the complex number: "
    @real = gets.chomp.to_f
    print "Enter the imaginary value of the complex number: "
    @imag = gets.chomp.to_f
  end
  
  def add(a, b, c, d)
    @real = a + c
    @imag = b + d
  end
  
  def subtract(a, b, c, d)
    @real = a - c
    @imag = b - d
  end
  
  def multiply(a, b, c, d)
    @real = a * c - b * d
    @imag = a * d + b * c
  end
  
  def divide(a, b, c, d)
    @real = (a * c + b * d) / (c * c + d * d)
    @imag = (b * c - a * d) / (c * c + d * d)
  end
  
  def get_data
    if @imag >= 0
      puts "#{@real}+#{@imag}i"
    else
      puts "#{@real}#{@imag}i"
    end
  end
end

x1 = Complex.new
x2 = Complex.new
addition = Complex.new
subtraction = Complex.new
multiplication = Complex.new
division = Complex.new

x1.set_data
x2.set_data

puts "Complex number 1 is:"
x1.get_data
puts "Complex number 2 is:"
x2.get_data

ans = 1
while ans == 1
  puts "Choose the operation to perform:"
  puts "1. Addition\n2. Subtraction\n3. Multiplication\n4. Division"
  a = gets.chomp.to_i

  if a == 1
    addition.add(x1.real, x1.imag, x2.real, x2.imag)
    puts "Addition of Complex 1 and Complex 2 is:"
    addition.get_data
  elsif a == 2
    subtraction.subtract(x1.real, x1.imag, x2.real, x2.imag)
    puts "Subtraction of Complex 2 from Complex 1 is:"
    subtraction.get_data
  elsif a == 3
    multiplication.multiply(x1.real, x1.imag, x2.real, x2.imag)
    puts "Multiplication of Complex 1 and Complex 2 is:"
    multiplication.get_data
  elsif a == 4
    if x2.real == 0 && x2.imag == 0
      puts "Can't divide by zero"
    else
      division.divide(x1.real, x1.imag, x2.real, x2.imag)
      puts "On division of Complex 1 by Complex 2, we get:"
      division.get_data
    end
  else
    puts "Invalid option chosen!"
  end

  print "Do you want to check more? (1 for yes / 2 for no): "
  ans = gets.chomp.to_i
  break if ans == 2
end

puts "\nThank you"
