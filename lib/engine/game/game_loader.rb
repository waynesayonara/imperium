require_relative 'game_state'
require_relative '../../../lib/engine/log/game_logger'
require_relative '../../../lib/engine/map/map_parse_exception'

module Engine
  module Game
    extend self

    $LOGGER = Log::GameLogger.new(STDOUT, 'GameLoader')

    #Starts new game using map
    def load_game_from_map(map_path)
      $LOGGER.info "Loading map from file. Path: '#{map_path}'"
      begin
        game_state = Game::GameState.new [Map::GameMap.new(Map.load_map(map_path))], Character::Character.new
        $LOGGER.info "Map with id: '#{game_state.current_map}' loaded successful."
        return game_state
      rescue Map::MapParseException, NoMethodError => e
        $LOGGER.error "Errors occured while map loading:"
        $LOGGER.error e.message
        fail e
      end
    end

    #Loads game using save file
    def load_game_from_save
      #TODO implement game state saving and loading
    end

  end
end