require 'io/console'

COLORS = ["Red", "Orange", "White", "Black", "Green", "Blue", "Brown", "Purple", "Cyan", "Yellow", "Pink", "Magenta"]

score = 0
displayed_word_color = ''
game_running = false

def print_score(score)
  puts "Your Score: #{score}"
end

def print_time_left(seconds_left)
  puts "Game Ends in: #{seconds_left}s"
end

def print_game_description
  puts "Game Description: Enter the color of the words displayed below."
  puts "And keep in mind not to enter the word text itself"
end

def start_game
  if !game_running
    game_running = true
    system("clear")
    print_game_description
    print_score(score)
    print_time_left(60)
    displayed_word_color = COLORS.sample
  end
end

def stop_game
  game_running = false
  system("clear")
  puts "Game Over!"
end

def next_word
  if game_running
    displayed_word_text = COLORS.sample
    puts displayed_word_text
    print "Enter the color: "
    displayed_word_color = COLORS.sample
  end
end

def check_word(user_input)
  if game_running
    user_input.downcase!
    if user_input == displayed_word_color.downcase
      score += 1
      print_score(score)
    end
    next_word
  end
end

loop do
  key = STDIN.getch
  if key == ' '
    start_game
  elsif key == "\r"
    print "Enter the color: "
    user_input = gets.chomp
    check_word(user_input)
  end
end
