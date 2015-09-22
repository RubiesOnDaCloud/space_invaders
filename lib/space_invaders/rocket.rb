require "space_invaders/laser"
require "space_invaders/positionable"

module SpaceInvaders
  class Rocket
    include Positionable
    attr_reader :lives, :score

    def initialize(x, y, z, max_x)
      @image = Gosu::Image.new("media/images/rocket.png")
      @initial_x = x
      @initial_y = y
      @initial_z = z
      @x = x
      @y = y
      @z = z
      @scale = 1.0
      @max_x = max_x
      @lasers = []
      @dead = false
      @exploded = false
      @death_counter = 0
      @hit = false
      @hit_counter = 0
      @lives = 3
      @score = 0
    end

    def hit!
      return if dead?
      @hit = true
      @image = Gosu::Image.new("media/images/rocket_explosion.png")
      @lives -= 1
      if @lives.zero?
        @dead = true
        Gosu::Sample.new("media/sounds/dying.wav").play
      else
        Gosu::Sample.new("media/sounds/grenade.wav").play
      end
    end

    def respawn!
      @image = Gosu::Image.new("media/images/rocket.png")
      @x = @initial_x
      @y = @initial_y
      @z = @initial_z
      @scale = 1.0
      @hit = false
      @hit_counter = 0
    end

    def hit?
      @hit
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

    def exploded?
      @exploded
    end

    def move_left
      return if hit?
      @x -= 10
      if @x < 0
        @x = 0
      end
    end

    def move_right
      return if hit?
      @x += 10
      if @x > @max_x - width
        @x = @max_x - width
      end
    end

    def fire_laser
      return if hit?
      @lasers << Laser.new(@x + (width/2) - 2, @y - 1, 0, "yellow", -5)
    end

    def update(aliens)
      if dead?
        return if @exploded
        @death_counter += 1
        if @death_counter >= 120
          @exploded = true
        end
        @scale = 0.000005 * @death_counter ** 3 + 0.000005 * @death_counter + 1
      elsif hit?
        @hit_counter += 1
        @scale = (120 - @hit_counter) / 120.0
        respawn! if @hit_counter >= 120
      end
      if laser_count >= 1 && @lasers.first.y <= -16
        @lasers = []
      end
      @lasers.each do |laser|
        laser.update
        aliens.select { |alien| alien.alive? }.each do |alien|
          if laser.collides_with?(alien)
            alien.die!
            @lasers = []
            @score += 10
          end
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
