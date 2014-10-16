module Engine
  module Game
    class GameState

      attr_reader :game_maps
      attr_accessor :current_map, :character

      def initialize(game_maps, character)
        @character = character
        @game_maps = game_maps
        @current_map = game_maps.detect { |o| o.is_main }.map_id
      end

      # Returns current GameMap
      def get_current_map
        @game_maps.detect { |map| map.map_id == @current_map }
      end

      def render_map
        get_current_map.draw(@character.x, @character.y)
      end

      def render_char
        @character.draw
      end

    end
  end
end