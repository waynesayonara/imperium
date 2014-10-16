
module Engine

  #Base game object. Each game object (npc, castle, chest..) should extend this class
  class BaseGameObject

    attr_accessor :x, :y, :type, :name

    def initialize(x, y, type, name)
      @x = x
      @y = y
      @type = type
      @name = name
    end

    def move(x, y)
      @x += x
      @y += y
    end

    public :move

    def to_s
      "Name: #{@name}, Type: #{@type}, Position: #{@x}, #{@y}"
    end

  end
end