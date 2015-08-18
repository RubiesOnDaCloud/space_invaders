module SpaceInvaders
  class Laser
    attr_reader :y

    def initialize(x, y, z, color, velocity)
      @image = Gosu::Image.new("media/images/lasers/" + color + ".png")
      Gosu::Sample.new("media/sounds/laser.wav").play
      @velocity = velocity
      @x = x
      @y = y + @velocity
      @z = z
    end

    def update
      @y = @y + @velocity
    end

    def draw
      @image.draw(@x, @y, @z)
    end
  end
end
