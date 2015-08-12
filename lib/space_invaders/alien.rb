module SpaceInvaders
  class Alien
    attr_reader :x, :y

    def initialize(x, y, z)
      @image = Gosu::Image.new("media/images/alien.png")
      @x = x
      @y = y
      @z = z
      @scale = 0.5
      @velocity_x = 10
      @counter = 0
    end

    def update
      @counter = @counter + 1
      if @counter % 40 == 0
        @x = @x + @velocity_x
      end
    end

    def draw
      @image.draw(@x, @y, 0, @scale, @scale)
    end
  end
end
