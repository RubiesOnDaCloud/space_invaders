require "gosu"
require "space_invaders/rocket"
require "space_invaders/alien"

module SpaceInvaders
  class Window < Gosu::Window
    WIDTH = 640
    HEIGHT = 441

    def initialize
      super(WIDTH, HEIGHT)
      @background = Gosu::Image.new("media/images/background.jpg")
      # FIXME: Use the rocket's height instead of hardcoding 60
      @rocket = Rocket.new(WIDTH / 2, HEIGHT - 110, 0, WIDTH-1)
      @aliens = 10.times.collect do |number_of_times_through_the_loop|
        Alien.new(60 * number_of_times_through_the_loop, 0, 0)
      end
    end

    def update
      if Gosu::button_down?(Gosu::KbLeft)
        @rocket.move_left
      end
      if Gosu::button_down?(Gosu::KbRight)
        @rocket.move_right
      end
      @aliens.each do |alien|
        alien.update
      end
    end

    def draw
      @background.draw(0, 0, -1)
      @rocket.draw
      @aliens.each do |alien|
        alien.draw
      end
    end
  end
end
