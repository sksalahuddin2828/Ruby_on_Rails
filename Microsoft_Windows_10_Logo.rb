require 'ruby2d'

set width: 400, height: 400, title: 'Turtle Graphics'

class Turtle
  attr_accessor :pen_color, :pen_width, :pen_down

  def initialize
    @lines = []
    @pen_color = 'white'
    @pen_width = 1
    @pen_down = true
  end

  def go_to(x, y)
    if @pen_down
      @lines << [x, y]
    end
  end

  def draw
    @lines.each_cons(2) do |p1, p2|
      Line.new(x1: p1[0], y1: p1[1], x2: p2[0], y2: p2[1], width: @pen_width, color: @pen_color)
    end
  end
end

turtle = Turtle.new
turtle.pen_color = 'white'
turtle.pen_width = 1
turtle.pen_down = true
turtle.go_to(-50, 60)
turtle.go_to(100, 100)
turtle.go_to(100, -100)
turtle.go_to(-50, -60)
turtle.go_to(-50, 60)
turtle.go_to(15, 100)
turtle.go_to(15, -100)
turtle.go_to(100, 0)
turtle.go_to(-100, 0)

update do
  clear
  turtle.draw
end

show
