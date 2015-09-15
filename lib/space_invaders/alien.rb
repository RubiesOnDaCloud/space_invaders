require 'space_invaders/laser'
require 'space_invaders/positionable'

module SpaceInvaders
  class Alien
    include Positionable
  
    @@velocity_x = 10
    @@speed = 40

    def initialize(x, y, z)
      @image = Gosu::Image.new("media/images/alien.png")
      @x = x
      @y = y
      @z = z
      @scale = 1.0
      @counter = 0
      @lasers = []
      @death_counter = 0
      @dead = false
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

    def fire_laser
      @lasers << Laser.new(@x + width / 2 - 2, @y, 0, "purple", +5)
    end

    def hits_wall
      @@velocity_x *= -1
      @@speed = [@@speed-5, 1].max
    end
    private :hits_wall

    def update(rocket)
      if @@velocity_x >= 0
        hits_wall if right >= 640
      else
        hits_wall if left <= 0
      end

      if dead?
        @death_counter += 1
        @scale = (30 - @death_counter) / 30.0
      elsif rocket.hit?
        # pause
      else
        @counter += 1
        if @counter % @@speed == 0
          @x += @@velocity_x
        end
      end
      @lasers.each do |laser|
        laser.update
        if laser.collides_with?(rocket)
          rocket.hit!
          @lasers.delete(laser)
        end
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
