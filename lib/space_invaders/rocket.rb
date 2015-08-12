require "space_invaders/laser"

module SpaceInvaders
  class Rocket
    attr_reader :x

    def initialize(x, y, z, max_x)
      @image = Gosu::Image.new("media/images/rocket.png")
      @x = x
      @y = y
      @z = z
      @max_x = max_x
      @lasers = []
    end

    def laser_count
      @lasers.count
    end

    def move_left
      @x -= 10
      if @x < 0
        @x = 0
      end
    end

    def move_right
      @x += 10
      if @x > @max_x - @image.width
        @x = @max_x - @image.width
      end
    end

    def fire_laser
      @lasers << Laser.new(@x + (@image.width/2) - 2, @y - 1, 0, "yellow")
    end

    def height
      @image.height
    end

    def update
      if laser_count >= 1 && @lasers.first.y <= -16
        @lasers = []
      end
    end

    def draw
      @image.draw(@x, @y, @z)
      @lasers.each do |laser|
        laser.draw
      end
    end
  end
end
