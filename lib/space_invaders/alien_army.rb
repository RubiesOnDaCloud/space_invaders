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
      for row in 1..5
        for col in 1..11
          @aliens << Alien.new(45 * col, 35 * (row+1), 1, row_score(row))
        end
      end
    end

    def row_score(row)
      case row
      when 1 
        40
      when 2..3
        20
      else
        10
      end
    end
    private :row_score

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
      @aliens.each {|alien| alien.speed = [alien.speed+5, 35].min}
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


