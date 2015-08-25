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
      @death_counter = 0
      @dead = false
    end

    def die!
      @dead = true
      @image = Gosu::Image.new("media/images/collision.png")
      Gosu::Sample.new("media/sounds/glass.wav").play
    end

    def dead?
      @dead
    end

    def alive?
      not @dead
    end

    def fire_laser
      @lasers << Laser.new(@x + (@image.width/2) - 2, @y, 0, "purple", +5)
    end

    def update
      if dead?
        @death_counter += 1
      else
        @counter += 1
        if @counter % 40 == 0
          @x = @x + @velocity_x
        end
      end
      @lasers.each do |laser|
        laser.update
      end
    end

    def draw
      @image.draw(@x, @y, @z) if @death_counter < 30
      @lasers.each do |laser|
        laser.draw
      end
    end
  end
end
