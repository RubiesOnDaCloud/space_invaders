require "gosu"
require "space_invaders/rocket"
require "space_invaders/alien_army"

module SpaceInvaders
  class Window < Gosu::Window
    WIDTH = 640
    HEIGHT = 481

    def initialize
      super(WIDTH, HEIGHT)
      reset
    end

    def reset
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
      if Gosu::button_down?(Gosu::KbN) && @rocket.exploded?
        close
      end
      if Gosu::button_down?(Gosu::KbY) && @rocket.exploded?
        reset
      end
      @alien_army.update(@rocket)
      if @alien_army.bottom >= HEIGHT - @rocket.height
        @rocket.die!
      end
      @rocket.update(@alien_army)
      @counter = @counter + 1
      if @counter % 120 == 0 && !@rocket.hit? && !@alien_army.all_dead?
        @alien_army.alive_aliens.sample.fire_laser
      end
    end

    def draw
      if @rocket.exploded?
        @gameover = Gosu::Font.new(55)
        @gameover.draw("GAME OVER", 170, 100, 3, 1.0, 2.0, 0xff_000000)
        @continue = Gosu::Font.new(30)
        @continue.draw("Continue ? (y/n)", 220, 220, 3, 1.0, 1.0, 0xff_00aff0)
      end
      if @alien_army.all_dead?
        @win = Gosu::Font.new(55)
        @win.draw("YOU WON", 170, 100, 3, 1.0, 2.0, 0xff_ffffff)
      end
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

