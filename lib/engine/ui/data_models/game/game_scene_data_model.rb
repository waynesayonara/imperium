require_relative '../../../../../lib/engine/game/game_state'

module Engine
  module DataModels
    class GameSceneDataModel
      private
      attr_writer :game_data

      public
      attr_reader :game_data

      def initialize(game_data)
        fail ArgumentError.new 'Input game data cannot be nil' if game_data.nil?
        fail ArgumentError 'Input game data must represent an initialized GameState' unless game_data.is_a?(Engine::Game::GameState) || game_data.character || game_data.game_maps || game_data.current_map

        #unless game_data.values.all? { |v| v.is_a?(Imperium::DataModels::MenuSceneElementDataModel) }
        #  raise ArgumentError.new "Input menu elements must be of type #{Imperium::DataModels::MenuSceneElementDataModel}"
        #end

        self.game_data = game_data
      end
    end
  end
end
