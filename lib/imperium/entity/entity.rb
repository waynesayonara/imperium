require_relative 'base_game_object'
require_relative '../../../lib/imperium'

module Imperium
  module GameEntity

    #Base class for 'living' entities (NPC)
    class Entity < BaseGameObject

      attr_accessor :properties

      def initialize(x, y, type, name, properties)
        super(x, y, type, name)
        @properties = properties
      end
    end
  end
end