require "gosu"

module SpaceInvaders
  class Window < Gosu::Window
    def initialize
      super(640, 441)
      @background = Gosu::Image.new("media/background.jpg")
    end

    def update
    end

    def draw
      @background.draw(0, 0, 0)
    end
  end
end
