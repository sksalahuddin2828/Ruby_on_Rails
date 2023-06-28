# gem install gosu

require 'gosu'

WIDTH = 800
HEIGHT = 600
PADDLE_WIDTH = 100
PADDLE_HEIGHT = 15
BALL_RADIUS = 10
LIVES_FONT = Gosu::Font.new(40)

class Paddle
  VEL = 5
  
  attr_accessor :x, :y, :width, :height, :color

  def initialize(x, y, width, height, color)
    @x = x
    @y = y
    @width = width
    @height = height
    @color = color
  end

  def draw
    Gosu.draw_rect(@x, @y, @width, @height, @color)
  end

  def move(direction = 1)
    @x += VEL * direction
  end
end

class Ball
  VEL = 5
  
  attr_accessor :x, :y, :radius, :color, :x_vel, :y_vel

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
    Gosu.draw_circle(@x, @y, @radius, 0, @color)
  end
end

class Brick
  attr_accessor :x, :y, :width, :height, :health, :max_health, :colors, :color

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
    Gosu.draw_rect(@x, @y, @width, @height, @color)
  end

  def collide(ball)
    return false unless (ball.x <= @x + @width) && (ball.x >= @x)
    return false unless (ball.y - ball.radius <= @y + @height)

    hit
    ball.set_vel(ball.x_vel, ball.y_vel * -1)
    true
  end

  def hit
    @health -= 1
    @color = interpolate(*@colors, @health.to_f / @max_health)
  end

  def interpolate(color_a, color_b, t)
    color_a.zip(color_b).map { |a, b| (a + (b - a) * t).to_i }
  end
end

class GameWindow < Gosu::Window
  def initialize
    super(WIDTH, HEIGHT, false)
    self.caption = "Sk. Salahuddin - Morning 01 Batch"
    @font = Gosu::Font.new(40)

    @paddle = Paddle.new(WIDTH / 2 - PADDLE_WIDTH / 2, HEIGHT - PADDLE_HEIGHT - 5, PADDLE_WIDTH, PADDLE_HEIGHT, Gosu::Color::WHITE)
    @ball = Ball.new(WIDTH / 2, @paddle.y - BALL_RADIUS, BALL_RADIUS, Gosu::Color::RED)
    @bricks = generate_bricks(3, 10)
    @lives = 3
  end

  def generate_bricks(rows, cols)
    gap = 2
    brick_width = WIDTH / cols - gap
    brick_height = 20
    bricks = []

    rows.times do |row|
      cols.times do |col|
        brick = Brick.new(col * brick_width + gap * col, row * brick_height + gap * row, brick_width, brick_height, 2, [[0, 255, 0], [255, 0, 0]])
        bricks << brick
      end
    end

    bricks
  end

  def reset
    @paddle.x = WIDTH / 2 - PADDLE_WIDTH / 2
    @paddle.y = HEIGHT - PADDLE_HEIGHT - 5
    @ball.x = WIDTH / 2
    @ball.y = @paddle.y - BALL_RADIUS
  end

  def draw
    Gosu.draw_rect(0, 0, WIDTH, HEIGHT, Gosu::Color::BLACK)
    @paddle.draw
    @ball.draw
    @bricks.each(&:draw)

    @font.draw_text("Lives: #{@lives}", 10, HEIGHT - @font.height - 10, 0)

    unless @game_over.nil?
      @font.draw_text(@game_over, WIDTH / 2 - @font.text_width(@game_over) / 2, HEIGHT / 2 - @font.height / 2, 0)
    end
  end

  def update
    if @lives.zero?
      @game_over = "You Lost!"
      reset
      @bricks = generate_bricks(3, 10)
      sleep(3)
      @lives = 3
      @game_over = nil
    elsif @bricks.empty?
      @game_over = "You Won!"
      reset
      @bricks = generate_bricks(3, 10)
      sleep(3)
      @lives = 3
      @game_over = nil
    else
      @ball.move
      ball_collision
      ball_paddle_collision
      @bricks.each do |brick|
        brick.collide(@ball)
        @bricks.delete(brick) if brick.health <= 0
      end

      if @ball.y + BALL_RADIUS >= HEIGHT
        @lives -= 1
        @ball.x = @paddle.x + @paddle.width / 2
        @ball.y = @paddle.y - BALL_RADIUS
        @ball.set_vel(0, @ball.VEL * -1)
      end
    end
  end

  def ball_collision
    if @ball.x - BALL_RADIUS <= 0 || @ball.x + BALL_RADIUS >= WIDTH
      @ball.set_vel(@ball.x_vel * -1, @ball.y_vel)
    end

    if @ball.y + BALL_RADIUS >= HEIGHT || @ball.y - BALL_RADIUS <= 0
      @ball.set_vel(@ball.x_vel, @ball.y_vel * -1)
    end
  end

  def ball_paddle_collision
    return unless @ball.x <= @paddle.x + @paddle.width && @ball.x >= @paddle.x
    return unless @ball.y + @ball.radius >= @paddle.y

    paddle_center = @paddle.x + @paddle.width / 2
    distance_to_center = @ball.x - paddle_center
    percent_width = distance_to_center.to_f / @paddle.width
    angle = percent_width * 90
    angle_radians = Gosu::degrees_to_radians(angle)
    x_vel = Math.sin(angle_radians) * @ball.VEL
    y_vel = Math.cos(angle_radians) * @ball.VEL * -1
    @ball.set_vel(x_vel, y_vel)
  end

  def button_down(id)
    case id
    when Gosu::KB_LEFT
      @paddle.move(-1) if @paddle.x - Paddle::VEL >= 0
    when Gosu::KB_RIGHT
      @paddle.move(1) if @paddle.x + @paddle.width + Paddle::VEL <= WIDTH
    when Gosu::KB_ESCAPE
      close
    end
  end
end

GameWindow.new.show
