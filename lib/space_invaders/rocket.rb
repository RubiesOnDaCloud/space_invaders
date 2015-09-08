require "space_invaders/laser"
require "space_invaders/positionable"

module SpaceInvaders
  class Rocket
    include Positionable

    def initialize(x, y, z, max_x)
      @image = Gosu::Image.new("media/images/rocket.png")
      @x = x
      @y = y
      @z = z
      @scale = 1.0
      @max_x = max_x
      @lasers = []
      @death_counter = 0
      @dead = false
    end

    def die!
      return if dead?
      @dead = true
      @image = Gosu::Image.new("media/images/rocket_explosion.png")
      Gosu::Sample.new("media/sounds/dying.wav").play
    end

    def dead?
      @dead
    end

    def alive?
      not @dead
    end

    def laser_count
      @lasers.count
    end

    def move_left
      return if dead?
      @x -= 10
      if @x < 0
        @x = 0
      end
    end

    def move_right
      return if dead?
      @x += 10
      if @x > @max_x - width
        @x = @max_x - width
      end
    end

    def fire_laser
      return if dead?
      @lasers << Laser.new(@x + (width/2) - 2, @y - 1, 0, "yellow", -5)
    end

    def update(aliens)
      if dead?
        @death_counter += 1
        @scale = 0.000005 * @death_counter ** 3 + 0.000005 * @death_counter + 1
      end
      if laser_count >= 1 && @lasers.first.y <= -16
        @lasers = []
      end
      @lasers.each do |laser|
        laser.update
        aliens.each do |alien|
          alien.die! if laser.collides_with?(alien)
        end
      end
    end

    def draw
      offset_x = width * (1 - @scale) / 2
      offset_y = height * (1 - @scale) / 2
      @image.draw(@x + offset_x, @y + offset_y, @z, @scale, @scale)
      @lasers.each do |laser|
        laser.draw
      end
    end
  end
end
