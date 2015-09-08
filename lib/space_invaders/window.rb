require "gosu"
require "space_invaders/rocket"
require "space_invaders/alien"

module SpaceInvaders
  class Window < Gosu::Window
    WIDTH = 640
    HEIGHT = 481

    def initialize
      super(WIDTH, HEIGHT)
      @font = Gosu::Font.new(20)
      @background = Gosu::Image.new("media/images/background.jpg")
      # FIXME: Use the rocket's height instead of hardcoding 110
      @rocket = Rocket.new(WIDTH / 2, HEIGHT - 110, 2, WIDTH - 1)
      @aliens = []
      for row in 2..6
        for col in 0..10
          @aliens << Alien.new(45 * col, 35 * row, 1)
        end
      end
      @counter = 0
    end

    def update
      if Gosu::button_down?(Gosu::KbLeft)
        @rocket.move_left
      end
      if Gosu::button_down?(Gosu::KbRight)
        @rocket.move_right
      end
      if Gosu::button_down?(Gosu::KbSpace) && @rocket.laser_count.zero?
        @rocket.fire_laser
      end
      @aliens.each do |alien|
        alien.update(@rocket)
      end
      @rocket.update(@aliens)
      @counter = @counter + 1
      if @counter % 120 == 0 && @rocket.alive?
        @aliens.select(&:alive?).sample.fire_laser
      end
    end

    def draw
      @font.draw("Score: #{@rocket.score}", 10, 10, 1)
      @background.draw(0, 40, -1)
      @rocket.draw
      @aliens.each do |alien|
        alien.draw
      end
    end
  end
end
