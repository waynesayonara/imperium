require_relative '../entity/base_game_object'

module Engine
  module Character
    class Character < BaseGameObject

      DIRECTION_DOWN = 0
      DIRECTION_UP = 1
      DIRECTION_LEFT = 2
      DIRECTION_RIGHT = 3
      CHAR_X_TILES = 6
      CHAR_Y_TILES = 4

      def initialize
        super(0, 0, "Character", "Name")
        @animation = Gosu::Image.load_tiles($window, '../resources/character/char.png', -CHAR_X_TILES, -CHAR_Y_TILES, true)
        @direction = DIRECTION_DOWN
        @is_moving = false
      end

      def draw
        from = CHAR_X_TILES * @direction
        to = CHAR_X_TILES * (@direction + 1) - 1
        @animation[from..to][Gosu::milliseconds / 100 % CHAR_X_TILES].draw(@x, @y, 0)
      end

      def move(x, y)
        @x += x
        @y += y
        switch_direction(x, y)
      end

      def switch_direction(x, y)
        @direction = DIRECTION_RIGHT if @x + x > @x
        @direction = DIRECTION_LEFT if @x + x < @x
        @direction = DIRECTION_DOWN if @y + y > @y
        @direction = DIRECTION_UP if @y + y < @y
      end
      private :switch_direction

    end
  end
end