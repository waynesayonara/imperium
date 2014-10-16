require 'tmx'
module Engine
  module Map
    extend self

    TEST_PATH = '../resources/maps/map.tmx'

    def load_map(path)
      Tmx.load(path)
    end
  end
end

