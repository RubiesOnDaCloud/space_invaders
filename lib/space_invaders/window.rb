require "gosu"
require "space_invaders/rocket"

module SpaceInvaders
  class Window < Gosu::Window
    WIDTH = 640
    HEIGHT = 441

    def initialize
      super(WIDTH, HEIGHT)
      @background = Gosu::Image.new("media/images/background.jpg")
      @rocket = Rocket.new
    end

    def update
    end

    def draw
      @background.draw(0, 0, -1)
      @rocket.draw(WIDTH / 2, HEIGHT - @rocket.height, 0)
    end
  end
end
