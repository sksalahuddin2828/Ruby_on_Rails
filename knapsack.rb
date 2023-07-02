def stack_sack(items, weight, value, number)
  knapsack = Array.new(number + 1) { Array.new(items + 1, 0) }

  # Build table for knapsack[][] in bottom-up manner
  for i in 0..number
    for j in 0..items
      if i == 0 || j == 0
        knapsack[i][j] = 0
      elsif weight[i - 1] <= j
        knapsack[i][j] = [value[i - 1] + knapsack[i - 1][j - weight[i - 1]], knapsack[i - 1][j]].max
      else
        knapsack[i][j] = knapsack[i - 1][j]
      end
    end
  end

  return knapsack[number][items]
end

value = [60, 100, 120]
weight = [10, 20, 30]
items = 50
number = value.length

result = stack_sack(items, weight, value, number)
puts result
