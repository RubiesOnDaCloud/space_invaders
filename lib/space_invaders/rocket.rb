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
      @max_x = max_x
      @lasers = []
    end

    def laser_count
      @lasers.count
    end

    def move_left
      @x -= 10
      if @x < 0
        @x = 0
      end
    end

    def move_right
      @x += 10
      if @x > @max_x - @image.width
        @x = @max_x - @image.width
      end
    end

    def fire_laser
      @lasers << Laser.new(@x + (@image.width/2) - 2, @y - 1, 0, "yellow", -5)
    end

    def height
      @image.height
    end

    def update(aliens)
      if laser_count >= 1 && @lasers.first.y <= -16
        @lasers = []
      end
      @lasers.each do |laser|
        laser.update
        aliens.each do |alien|
          alien.die! if alien.alive? && laser.collides_with?(alien)
        end
      end
    end

    def draw
      @image.draw(@x, @y, @z)
      @lasers.each do |laser|
        laser.draw
      end
    end
  end
end
