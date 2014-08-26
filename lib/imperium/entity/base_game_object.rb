require_relative '../../../lib/imperium'

module Imperium

  #Base game object. Each game object (npc, castle, chest..) should extend this class
  class BaseGameObject

    attr_accessor :x_coordinate, :y_coordinate, :type, :name

    def initialize(x, y, type, name)
      @x_coordinate = x
      @y_coordinate = y
      @type = type
      @name = name
    end

    def move(x, y)
      @x_coordinate += x
      @y_coordinate += y
    end

    protected :move

    def to_s
      "Name: #{@name}, Type: #{@type}, Position: #{@x_coordinate}, #{@y_coordinate}"
    end

  end
end