require 'space_invaders/alien'
require 'forwardable'

module SpaceInvaders
  class AlienArmy
    extend Forwardable
    def_delegators :@aliens, :each
    include Enumerable

    def initialize
      @direction = "right"
      @aliens = []
      for row in 2..6
        for col in 0..10
          @aliens << Alien.new(45 * col, 35 * row, 1)
        end
      end
    end

    def alive_aliens
      @aliens.select(&:alive?)
    end

    def left
      @aliens.map(&:left).min
    end

    def right
      @aliens.map(&:right).max
    end

    def bottom
      @aliens.map(&:bottom).max
    end

    def hits_wall
      if @direction == "right"
        @direction = "left" 
      else
        @direction = "right"
      end
      @aliens.each {|alien| alien.velocity_x *= -1}
      @aliens.each {|alien| alien.speed = [alien.speed-5, 1].max}
    end
    private :hits_wall

    def update(rocket)
      if @direction == "right"
        hits_wall if right >= 640
      else
        hits_wall if left <= 0
      end
      @aliens.each do |alien|
        alien.update(rocket)
      end
    end

  end 
end


