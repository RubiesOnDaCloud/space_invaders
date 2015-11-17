require 'space_invaders/laser'
require 'space_invaders/positionable'

module SpaceInvaders
  class Alien
    include Positionable
    attr_reader :score

    attr_accessor :velocity_x

    def initialize(x, y, z, score)
      @image = Gosu::Image.new("media/images/alien.png")
      @x = x
      @y = y
      @z = z
      @scale = 1.0
      @lasers = []
      @death_counter = 0
      @dead = false
      @velocity_x = 10
      @score = score
    end

    def die!
      return if dead?
      @dead = true
      @image = Gosu::Image.new("media/images/alien_explosion.png")
      Gosu::Sample.new("media/sounds/glass.wav").play
    end

    def dead?
      @dead
    end

    def alive?
      not @dead
    end

    def move
      @x += @velocity_x
    end

    def fire_laser
      @lasers << Laser.new(@x + width / 2 - 2, @y, 0, "purple", +5)
    end

    def update(rocket)
      @lasers.each do |laser|
        laser.update
        if laser.collides_with?(rocket)
          rocket.hit!
          @lasers.delete(laser)
        end
      end
      if dead?
        @death_counter += 1
        @scale = (30 - @death_counter) / 30.0
      end
    end

    def draw
      offset_x = width * (1 - @scale) / 2
      offset_y = height * (1 - @scale) / 2
      @image.draw(@x + offset_x, @y + offset_y, @z, @scale, @scale) if @death_counter < 30
      @lasers.each do |laser|
        laser.draw
      end
    end
  end
end
