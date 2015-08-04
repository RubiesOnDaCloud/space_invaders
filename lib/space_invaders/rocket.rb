module SpaceInvaders
  class Rocket
    attr_reader :x, :y, :z

    def initialize(x, y, z, max_x)
      @image = Gosu::Image.new("media/images/rocket.png")
      @x = x
      @y = y
      @z = z
      @max_x = max_x
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

    def height
      @image.height
    end

    def draw
      @image.draw(@x, @y, @z)
    end
  end
end
