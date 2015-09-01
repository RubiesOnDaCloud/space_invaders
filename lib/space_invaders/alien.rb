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
      @scale = 1.0
      @velocity_x = 10
      @counter = 0
      @lasers = []
      @death_counter = 0
      @dead = false
    end

    def die!
      return if dead?
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
        @scale = (30 - @death_counter) / 30.0
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
      offset_x = @image.width * (1 - @scale) / 2
      offset_y = @image.height * (1 - @scale) / 2
      @image.draw(@x + offset_x, @y + offset_y, @z, @scale, @scale) if @death_counter < 30
      @lasers.each do |laser|
        laser.draw
      end
    end
  end
end
