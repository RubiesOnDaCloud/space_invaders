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
      @counter = 0
      @speed = 1
      @music = [
        Gosu::Sample.new("media/sounds/1.wav"),
        Gosu::Sample.new("media/sounds/2.wav"),
        Gosu::Sample.new("media/sounds/3.wav"),
        Gosu::Sample.new("media/sounds/4.wav")
      ].cycle
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
      alive_aliens.map(&:left).min
    end

    def right
      alive_aliens.map(&:right).max
    end

    def bottom
      alive_aliens.map(&:bottom).max
    end

    def all_dead?
      alive_aliens.empty?
    end

    def hits_wall
      if @direction == "right"
        @direction = "left"
      else
        @direction = "right"
      end
      @aliens.each {|alien| alien.y += 10}
      @aliens.each {|alien| alien.velocity_x *= -1}
      @speed = [@speed+5, 35].min
    end
    private :hits_wall

    def ready_to_move?
      @counter % (41 - @speed) == 0
    end
    private :ready_to_move?

    def update(rocket)
      if @direction == "right"
        hits_wall if right >= 640
      else
        hits_wall if left <= 0
      end
      @counter += 1
      if ready_to_move?
        alive_aliens.each { |alien| alien.move }
        @music.next.play
      end
      unless rocket.hit?
        @aliens.each do |alien|
          alien.update(rocket)
        end
      end
    end

  end
end


