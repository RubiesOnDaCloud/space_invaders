require "forwardable"

module SpaceInvaders
  module Positionable
    attr_accessor :x, :y
    alias :top :y
    alias :left :x
    extend Forwardable
    def_delegators :@image, :height, :width

    def bottom
      y + height
    end

    def right
      x + width
    end
  end
end
