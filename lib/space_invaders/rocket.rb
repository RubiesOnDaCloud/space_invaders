module SpaceInvaders
  class Rocket
    def initialize
      @image = Gosu::Image.new("media/images/rocket.png")
    end

    def height
      @image.height
    end

    def draw(x, y, z)
      @image.draw(x, y, z)
    end
  end
end
