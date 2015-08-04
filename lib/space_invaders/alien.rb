module SpaceInvaders
  class Alien
    attr_reader :x, :y, :z

    def initialize(x, y, z)
      @image = Gosu::Image.new("media/images/alien.png")
      @x = x
      @y = y
      @z = z
      @scale = 1/2.to_f
      @velocity_x = 10
      @counter = 0
    end

    def update
      @counter = @counter + 1
      @x = @x + @velocity_x if @counter % 40 == 0
    end

    def draw
      @image.draw(@x, @y, 0, @scale, @scale)
    end
  end
end
