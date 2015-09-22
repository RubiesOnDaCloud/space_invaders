require "gosu"
require "space_invaders/rocket"
require "space_invaders/alien_army"

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
      @alien_army = AlienArmy.new
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
      @alien_army.update(@rocket)
      @rocket.update(@alien_army)
      @counter = @counter + 1
      if @counter % 120 == 0 && !@rocket.hit?
        @alien_army.alive_aliens.sample.fire_laser
      end
    end

    def draw
      @font.draw("Score: #{@rocket.score}", 10, 10, 1)
      @background.draw(0, 40, -1)
      @rocket.draw
      @rocket.lives.times do |n|
        life = Gosu::Image.new("media/images/rocket.png")
        scale = 0.2
        life.draw(WIDTH - 70 + 2 * life.width * scale * n, 10, 1, scale, scale)
      end
      @alien_army.each do |alien|
        alien.draw
      end
    end
  end
end
