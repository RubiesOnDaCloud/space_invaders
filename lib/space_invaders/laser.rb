require "space_invaders/positionable"

module SpaceInvaders
  class Laser
    include Positionable

    def initialize(x, y, z, color, velocity)
      @image = Gosu::Image.new("media/images/lasers/" + color + ".png")
      Gosu::Sample.new("media/sounds/laser.wav").play
      @velocity = velocity
      @x = x
      @y = y + @velocity
      @z = z
    end

    def collides_with?(object)
      object.bottom  > top    &&
        object.top   < bottom &&
        object.right > left   &&
        object.left  < right
    end

    def update
      @y = @y + @velocity
    end

    def draw
      @image.draw(@x, @y, @z)
    end
  end
end
