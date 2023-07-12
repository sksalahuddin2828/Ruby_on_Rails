income_list = []

puts "Enter the income of 10 people:"
10.times do |person|
  print "Enter income: "
  income = gets.chomp.to_i
  income_list << income
end

(0...9).each do |first_index|
  swap_count = 0
  min_income = income_list[first_index]
  min_index = first_index

  (first_index + 1...10).each do |second_index|
    if min_income > income_list[second_index]
      min_income = income_list[second_index]
      swap_count += 1
      min_index = second_index
    end
  end

  if swap_count != 0
    temp = income_list[first_index]
    income_list[first_index] = min_income
    income_list[min_index] = temp
  end
end

puts "Sorted income list:"
income_list.each do |income|
  puts income
end
