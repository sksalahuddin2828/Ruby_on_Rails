class Solution
  def min_difficulty(job_difficulty, d)
    n = job_difficulty.size
    return -1 if n < d

    memo = Array.new(n) { Array.new(d + 1, -1) }

    dp(job_difficulty, 0, d, memo)
  end

  def dp(job_difficulty, i, d, memo)
    return job_difficulty[i..-1].max if d == 1
    return Float::INFINITY if i == job_difficulty.size - 1
    return memo[i][d] unless memo[i][d] == -1

    cur_difficulty = job_difficulty[i]
    min_difficulty = Float::INFINITY

    (i...job_difficulty.size - d + 1).each do |j|
      cur_difficulty = [cur_difficulty, job_difficulty[j]].max
      change = cur_difficulty + dp(job_difficulty, j + 1, d - 1, memo)
      min_difficulty = [min_difficulty, change].min
    end

    memo[i][d] = min_difficulty
    min_difficulty
  end
end

job_difficulty = [6, 5, 4, 3, 2, 1]
days = 2

solution = Solution.new
result = solution.min_difficulty(job_difficulty, days)

puts "Minimum difficulty: #{result}"
