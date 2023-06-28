# Please note that you need to have the Ruby2D gem installed to run this code successfully.

require 'ruby2d'

# Difficulty settings
# Easy      ->  10
# Medium    ->  25
# Hard      ->  40
# Harder    ->  60
# Impossible->  120

difficulty = 25

# Window size
frame_size_x = 720
frame_size_y = 480

# Checks for errors encountered
check_errors = Pygame.init()
# pygame.init() example output -> (6, 0)
# second number in tuple gives number of errors
if check_errors[1] > 0
  puts "[!] Had #{check_errors[1]} errors when initialising game, exiting..."
  exit -1
else
  puts "[+] Game successfully initialised"
end

# Initialise game window
Pygame.display.set_caption('Sk. Salahuddin')
game_window = Pygame.display.set_mode([frame_size_x, frame_size_y])

# Colors (R, G, B)
black = Pygame.Color(0, 0, 0)
white = Pygame.Color(255, 255, 255)
red = Pygame.Color(255, 0, 0)
green = Pygame.Color(0, 255, 0)
blue = Pygame.Color(0, 0, 255)

# FPS (frames per second) controller
fps_controller = Pygame.time.Clock()

# Game variables
snake_pos = [100, 50]
snake_body = [[100, 50], [100-10, 50], [100-(2*10), 50]]

food_pos = [rand(1..(frame_size_x/10).to_i) * 10, rand(1..(frame_size_y/10).to_i) * 10]
food_spawn = true

direction = 'RIGHT'
change_to = direction

score = 0

# Game Over
def game_over
  my_font = Pygame.font.SysFont('times new roman', 90)
  game_over_surface = my_font.render('YOU DIED', true, red)
  game_over_rect = game_over_surface.get_rect()
  game_over_rect.midtop = [frame_size_x/2, frame_size_y/4]
  game_window.fill(black)
  game_window.blit(game_over_surface, game_over_rect)
  show_score(0, red, 'times new roman', 20)
  Pygame.display.flip
  sleep(3)
  Pygame.quit
  exit
end

# Score
def show_score(choice, color, font, size)
  score_font = Pygame.font.SysFont(font, size)
  score_surface = score_font.render('Score : ' + score.to_s, true, color)
  score_rect = score_surface.get_rect()
  if choice == 1
    score_rect.midtop = [frame_size_x/10, 15]
  else
    score_rect.midtop = [frame_size_x/2, frame_size_y/1.25]
  end
  game_window.blit(score_surface, score_rect)
end

# Main logic
loop do
  Pygame.event.get.each do |event|
    if event.type == Pygame::QUIT
      Pygame.quit
      exit
    elsif event.type == Pygame::KEYDOWN
      if event.key == Pygame::K_UP || event.key == ord('w')
        change_to = 'UP'
      end
      if event.key == Pygame::K_DOWN || event.key == ord('s')
        change_to = 'DOWN'
      end
      if event.key == Pygame::K_LEFT || event.key == ord('a')
        change_to = 'LEFT'
      end
      if event.key == Pygame::K_RIGHT || event.key == ord('d')
        change_to = 'RIGHT'
      end
      if event.key == Pygame::K_ESCAPE
        Pygame.event.post(Pygame::Event.new(Pygame::QUIT))
      end
    end
  end

  # Making sure the snake cannot move in the opposite direction instantaneously
  if change_to == 'UP' && direction != 'DOWN'
    direction = 'UP'
  end
  if change_to == 'DOWN' && direction != 'UP'
    direction = 'DOWN'
  end
  if change_to == 'LEFT' && direction != 'RIGHT'
    direction = 'LEFT'
  end
  if change_to == 'RIGHT' && direction != 'LEFT'
    direction = 'RIGHT'
  end

  # Moving the snake
  if direction == 'UP'
    snake_pos[1] -= 10
  end
  if direction == 'DOWN'
    snake_pos[1] += 10
  end
  if direction == 'LEFT'
    snake_pos[0] -= 10
  end
  if direction == 'RIGHT'
    snake_pos[0] += 10
  end

  # Snake body growing mechanism
  snake_body.insert(0, snake_pos.clone)
  if snake_pos[0] == food_pos[0] && snake_pos[1] == food_pos[1]
    score += 1
    food_spawn = false
  else
    snake_body.pop
  end

  # Spawning food on the screen
  if !food_spawn
    food_pos = [rand(1..(frame_size_x/10).to_i) * 10, rand(1..(frame_size_y/10).to_i) * 10]
  end
  food_spawn = true

  # GFX
  game_window.fill(black)
  snake_body.each do |pos|
    Pygame.draw.rect(game_window, green, [pos[0], pos[1], 10, 10])
  end
  Pygame.draw.rect(game_window, white, [food_pos[0], food_pos[1], 10, 10])

  # Game Over conditions
  if snake_pos[0] < 0 || snake_pos[0] > frame_size_x-10
    game_over
  end
  if snake_pos[1] < 0 || snake_pos[1] > frame_size_y-10
    game_over
  end
  snake_body[1..-1].each do |block|
    if snake_pos[0] == block[0] && snake_pos[1] == block[1]
      game_over
    end
  end

  show_score(1, white, 'consolas', 20)
  Pygame.display.update
  fps_controller.tick(difficulty)
end
