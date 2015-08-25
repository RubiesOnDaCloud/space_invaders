require 'space_invaders/laser'
require 'space_invaders/positionable'

module SpaceInvaders
  class Alien
    include Positionable

    def initialize(x, y, z)
      @image = Gosu::Image.new("media/images/alien.png")
      @x = x
      @y = y
      @z = z
      @velocity_x = 10
      @counter = 0
      @lasers = []
    end

    def fire_laser
      @lasers << Laser.new(@x + (@image.width/2) - 2, @y, 0, "purple", +5)
    end

    def update
      @counter = @counter + 1
      if @counter % 40 == 0
        @x = @x + @velocity_x
      end
      @lasers.each do |laser|
        laser.update
      end
    end

    def draw
      @image.draw(@x, @y, 0)
      @lasers.each do |laser|
        laser.draw
      end
    end
  end
end
