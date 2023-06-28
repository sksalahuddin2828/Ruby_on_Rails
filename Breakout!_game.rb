# Please note that you need to have the Ruby2D gem installed to run this code successfully.

require 'ruby2d'

WIDTH, HEIGHT = 800, 600
set width: WIDTH, height: HEIGHT
set title: "Sk. Salahuddin - Morning 01 Batch"

FPS = 60
PADDLE_WIDTH = 100
PADDLE_HEIGHT = 15
BALL_RADIUS = 10
LIVES_FONT = 'resources/Roboto-Regular.ttf', 40

class Paddle
  VEL = 5
  
  attr_accessor :x, :y, :width
  
  def initialize(x, y, width, height, color)
    @x = x
    @y = y
    @width = width
    @height = height
    @color = color
  end
  
  def draw
    Rectangle.new(x: @x, y: @y, width: @width, height: @height, color: @color)
  end
  
  def move(direction = 1)
    @x += VEL * direction
  end
end

class Ball
  VEL = 5
  
  attr_accessor :x, :y, :x_vel, :y_vel
  
  def initialize(x, y, radius, color)
    @x = x
    @y = y
    @radius = radius
    @color = color
    @x_vel = 0
    @y_vel = -VEL
  end
  
  def move
    @x += @x_vel
    @y += @y_vel
  end
  
  def set_vel(x_vel, y_vel)
    @x_vel = x_vel
    @y_vel = y_vel
  end
  
  def draw
    Circle.new(x: @x, y: @y, radius: @radius, sectors: 32, color: @color)
  end
end

class Brick
  attr_accessor :health
  
  def initialize(x, y, width, height, health, colors)
    @x = x
    @y = y
    @width = width
    @height = height
    @health = health
    @max_health = health
    @colors = colors
    @color = colors[0]
  end
  
  def draw
    Rectangle.new(x: @x, y: @y, width: @width, height: @height, color: @color)
  end
  
  def collide(ball)
    return false unless (ball.x <= @x + @width) && (ball.x >= @x)
    return false unless ball.y - ball.radius <= @y + @height
    
    hit
    ball.set_vel(ball.x_vel, ball.y_vel * -1)
    true
  end
  
  def hit
    @health -= 1
    @color = interpolate(*@colors, @health.to_f / @max_health)
  end
  
  def interpolate(color_a, color_b, t)
    r = (color_a.red + (color_b.red - color_a.red) * t).to_i
    g = (color_a.green + (color_b.green - color_a.green) * t).to_i
    b = (color_a.blue + (color_b.blue - color_a.blue) * t).to_i
    
    Color.new(r, g, b)
  end
end

def draw(paddle, ball, bricks, lives)
  clear
  
  paddle.draw
  ball.draw
  
  bricks.each(&:draw)
  
  Text.new("Lives: #{lives}", x: 10, y: HEIGHT - 10 - LIVES_FONT[1], font: LIVES_FONT[0], size: LIVES_FONT[1]).draw
end

def ball_collision(ball)
  if ball.x - BALL_RADIUS <= 0 || ball.x + BALL_RADIUS >= WIDTH
    ball.set_vel(ball.x_vel * -1, ball.y_vel)
  end
  
  if ball.y + BALL_RADIUS >= HEIGHT || ball.y - BALL_RADIUS <= 0
    ball.set_vel(ball.x_vel, ball.y_vel * -1)
  end
end

def ball_paddle_collision(ball, paddle)
  return unless ball.x <= paddle.x + paddle.width && ball.x >= paddle.x
  return unless ball.y + ball.radius >= paddle.y
  
  paddle_center = paddle.x + paddle.width / 2
  distance_to_center = ball.x - paddle_center
  percent_width = distance_to_center / paddle.width
  angle = percent_width * 90
  angle_radians = Math::PI * angle / 180
  x_vel = Math.sin(angle_radians) * ball.VEL
  y_vel = Math.cos(angle_radians) * ball.VEL * -1
  ball.set_vel(x_vel, y_vel)
end

def generate_bricks(rows, cols)
  gap = 2
  brick_width = WIDTH / cols - gap
  brick_height = 20
  bricks = []
  
  rows.times do |row|
    cols.times do |col|
      brick = Brick.new(
        col * brick_width + gap * col,
        row * brick_height + gap * row,
        brick_width,
        brick_height,
        2,
        [Color.new(0, 255, 0), Color.new(255, 0, 0)]
      )
      bricks << brick
    end
  end
  
  bricks
end

def reset(paddle, ball)
  paddle.x = WIDTH / 2 - PADDLE_WIDTH / 2
  paddle.y = HEIGHT - PADDLE_HEIGHT - 5
  ball.x = WIDTH / 2
  ball.y = paddle.y - BALL_RADIUS
end

def display_text(text)
  Text.new(
    text,
    x: WIDTH / 2 - text.size / 2,
    y: HEIGHT / 2 - LIVES_FONT[1] / 2,
    font: LIVES_FONT[0],
    size: LIVES_FONT[1],
    color: 'red'
  ).draw
  
  show
  sleep(3)
end

paddle_x = WIDTH / 2 - PADDLE_WIDTH / 2
paddle_y = HEIGHT - PADDLE_HEIGHT - 5
paddle = Paddle.new(paddle_x, paddle_y, PADDLE_WIDTH, PADDLE_HEIGHT, 'white')
ball = Ball.new(WIDTH / 2, paddle_y - BALL_RADIUS, BALL_RADIUS, 'red')
bricks = generate_bricks(3, 10)
lives = 3

reset(paddle, ball)

on :key_held do |event|
  case event.key
  when 'left'
    paddle.move(-1) if paddle.x - paddle.VEL >= 0
  when 'right'
    paddle.move(1) if paddle.x + paddle.width + paddle.VEL <= WIDTH
  end
end

update do
  ball.move
  ball_collision(ball)
  ball_paddle_collision(ball, paddle)
  
  bricks.each do |brick|
    bricks.delete(brick) if brick.collide(ball) && brick.health <= 0
  end
  
  if ball.y + ball.radius >= HEIGHT
    lives -= 1
    ball.x = paddle.x + paddle.width / 2
    ball.y = paddle.y - BALL_RADIUS
    ball.set_vel(0, ball.VEL * -1)
  end
  
  if lives <= 0
    bricks = generate_bricks(3, 10)
    lives = 3
    reset(paddle, ball)
    display_text("You Lost!")
  end
  
  if bricks.empty?
    bricks = generate_bricks(3, 10)
    lives = 3
    reset(paddle, ball)
    display_text("You Won!")
  end
  
  draw(paddle, ball, bricks, lives)
end

show
