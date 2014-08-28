require_relative '../../../lib/imperium'
require_relative 'map_parse_exception'
require_relative 'tile_sets'
require_relative 'layer'
require_relative 'const'

module Imperium
  module Map
    class GameMap

      attr_reader :map_id, :display_name, :width, :height, :entities, :objects, :layers, :tilesets, :is_main

      # GameMap constructor.
      # Parameters: Tmx::Map.
      def initialize(map)
        @map_id = extract_property map, Const::MAP_ID
        @display_name = extract_property map, Const::MAP_DISPLAY_NAME
        @width = map.width * map.tilewidth
        @height = map.height * map.tileheight
        @is_main = extract_property(map, Const::MAP_IS_MAIN) == 'true'
        @tilesets = TileSets.new(map.tilesets, '../resources/maps/')

        fill_map_objects map.object_groups
        fill_layers map
      end

      # Read all OBJECTS from parsed map.
      private
      def extract(objects)
        objects.collect do |object|
          begin
            yield object
          rescue
            fail MapParseException.new, "Unknown object type: #{o.object}"
          end
        end.compact!
      end

      # Fill our map with parsed objects and entities
      def fill_map_objects(object_groups)
        @entities = extract(get_objects_by_type(object_groups, 'entities')) {
            |o| Imperium::GameEntity.const_get(o.type).new(o.x, o.y, o.type, o.name, o.properties.tap { |x| x.delete("image") })
        }
        #TODO: Parse objects from map
      end

      def get_objects_by_type(object_groups, type)
        object_groups.detect { |g| g.name == type }.objects
      end

      def extract_property(map, property)
        map.properties[property]
      end

      def fill_layers(map)
        @layers = []
        map.layers.each do |l|
          @layers << Layer.new(l, map)
        end
      end

      def draw(x, y)
        @layers.sort { |l1, l2| l1.index <=> l2.index }.each do |layer|
          layer.draw(x, y, @tilesets)
        end
      end
      public :draw

    end
  end
end
