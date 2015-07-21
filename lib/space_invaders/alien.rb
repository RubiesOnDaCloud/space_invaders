module SpaceInvaders
  class Alien
  	attr_reader :x, :y, :z

    def initialize(x, y, z)
      @image = Gosu::Image.new("media/images/alien.png")
      @x = x
      @y = y
      @z = z
    end

    def draw
      @image.draw(@x, @y, @z)
    end
  end
end
