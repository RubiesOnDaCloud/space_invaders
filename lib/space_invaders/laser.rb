module SpaceInvaders
  class Laser
    attr_reader :y
    def initialize(x, y, z, color)
      @image = Gosu::Image.new("media/images/lasers/" + color + ".png")
      Gosu::Sample.new("media/sounds/laser.wav").play
      @x = x
      @y = y
      @z = z
    end

    def draw
      @image.draw(@x, @y -= 5, @z)
    end
  end
end
