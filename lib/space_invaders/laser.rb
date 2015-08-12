module SpaceInvaders
  class Laser
    attr_reader :y
    def initialize(x, y, z, color)
      @image = Gosu::Image.new("media/images/lasers/" + color + ".png")
      Gosu::Sample.new("media/sounds/laser.wav").play
      @velocity = 5
      @x = x
      @y = y - @velocity
      @z = z
    end

    def draw
      @image.draw(@x, @y -= @velocity, @z)
    end
  end
end
