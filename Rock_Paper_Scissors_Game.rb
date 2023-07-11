# In the Ruby code, gets.chomp is used to read user input from the console. 
# The methods user_input_checker and game_logic handle user input and game logic, respectively.
# The play_game method is used to start the game loop.

def user_input_checker
  puts 'Enter your choice: '
  user_choice = gets.chomp
  if ['r', 'p', 's'].include?(user_choice)
    user_choice
  else
    puts 'Wrong Input!!'
    ''
  end
end

def game_logic(computer_choice, user_choice, user_score, computer_score)
  if computer_choice == 'rock' && user_choice == 'p'
    puts 'Player Wins'
    puts 'Enter 1 to continue and 0 to leave the game'
    user_score += 1
    i = gets.chomp.to_i
    [i, user_score, computer_score]
  elsif computer_choice == 'rock' && user_choice == 's'
    puts 'Computer Wins'
    puts 'Enter 1 to continue and 0 to leave the game'
    computer_score += 1
    i = gets.chomp.to_i
    [i, user_score, computer_score]
  elsif computer_choice == 'paper' && user_choice == 'r'
    puts 'Computer Wins'
    puts 'Enter 1 to continue and 0 to leave the game'
    computer_score += 1
    i = gets.chomp.to_i
    [i, user_score, computer_score]
  elsif computer_choice == 'paper' && user_choice == 's'
    puts 'Player Wins'
    puts 'Enter 1 to continue and 0 to leave the game'
    user_score += 1
    i = gets.chomp.to_i
    [i, user_score, computer_score]
  elsif computer_choice == 'scissors' && user_choice == 'r'
    puts 'Player Wins'
    puts 'Enter 1 to continue and 0 to leave the game'
    user_score += 1
    i = gets.chomp.to_i
    [i, user_score, computer_score]
  elsif computer_choice == 'scissors' && user_choice == 'p'
    puts 'Computer Wins'
    puts 'Enter 1 to continue and 0 to leave the game'
    computer_score += 1
    i = gets.chomp.to_i
    [i, user_score, computer_score]
  elsif computer_choice == user_choice
    puts 'Draw'
    puts 'Enter 1 to continue and 0 to leave the game'
    user_score += 1
    computer_score += 1
    i = gets.chomp.to_i
    [i, user_score, computer_score]
  end
end

def play_game
  choices = ['rock', 'paper', 'scissors']

  puts 'Welcome to the game!'
  puts 'Enter:'
  puts 'r for rock'
  puts 'p for paper'
  puts 's for scissors'

  print 'Enter your name: '
  player_name = gets.chomp

  i = 1
  user_score_total = 0
  computer_score_total = 0

  while i == 1
    user_input = user_input_checker
    while user_input.empty?
      user_input = user_input_checker
    end

    computer_choice = choices.sample
    puts 'Computer chooses: ' + computer_choice

    i, computer_score_total, user_score_total = game_logic(computer_choice, user_input, user_score_total, computer_score_total)

    if i == 0
      puts "Scores for this match are as follows:"
      puts "#{player_name}'s score: #{user_score_total}"
      puts "Computer's score: #{computer_score_total}"
      puts "Thank you for playing the game."
      puts "Have a nice day!"
    elsif i != 0 && i != 1
      puts "Invalid Input!"
      print "Please enter 1 to continue or 0 to leave the game: "
      i = gets.chomp.to_i
    end
  end
end

play_game
