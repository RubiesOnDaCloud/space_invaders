module SpaceInvaders
  class Rocket
    attr_reader :x, :y, :z

    def initialize(x, y, z)
      @image = Gosu::Image.new("media/images/rocket.png")
      @x = x
      @y = y
      @z = z
    end

    def move_left
      @x -= 10
    end

    def move_right
      @x += 10
    end

    def height
      @image.height
    end

    def draw
      @image.draw(@x, @y, @z)
    end
  end
end
