
module Imperium
  module DataModels
    class MenuSceneDataModelFactory
      include Engine
      private
      MENU_ELEMENTS_X_MARGIN = 280
      MENU_ELEMENTS_Y_MARGIN = 300

      public
      def self.create_start_menu_data_model
        menu_elements =
            {
            'new_game' => create_new_game_element_data_model,
            'load_game' => create_load_game_element_data_model,
            'exit' => create_exit_game_element_data_model
            }
        background = Gosu::Image.new($window, '../resources/menu/Imperium_splash_1024_800.png', false)

        return Engine::DataModels::MenuSceneDataModel.new(background, menu_elements)
      end

      def self.create_resume_game_menu_data_model
      end

      private
      def self.create_new_game_element_data_model
        area = Engine::Area.new(Engine::Point.new(MENU_ELEMENTS_X_MARGIN, MENU_ELEMENTS_Y_MARGIN), 464, 95)
        image_normal = Gosu::Image.new($window, '../resources/menu/new_game.png', false)
        image_active = Gosu::Image.new($window, '../resources/menu/new_game_selected.png', false)
        action = lambda { $window.push_scene(Imperium::GameScene.new(Engine::Game.load_game_from_map(Engine::Map::TEST_PATH))) }
        return Imperium::DataModels::MenuSceneElementDataModel.new(area, image_active, image_normal, action)
      end

      def self.create_load_game_element_data_model
        area = Engine::Area.new(Engine::Point.new(MENU_ELEMENTS_X_MARGIN, MENU_ELEMENTS_Y_MARGIN + 150), 464, 95)
        image_normal = Gosu::Image.new($window, '../resources/menu/load_game.png', false)
        image_active = Gosu::Image.new($window, '../resources/menu/load_game_selected.png', false)
        action = lambda { puts 'Not Implemented!' }
        return Imperium::DataModels::MenuSceneElementDataModel.new(area, image_active, image_normal, action)
      end

      def self.create_exit_game_element_data_model
        area = Engine::Area.new(Engine::Point.new(MENU_ELEMENTS_X_MARGIN, MENU_ELEMENTS_Y_MARGIN + 300), 464, 95)
        image_normal = Gosu::Image.new($window, '../resources/menu/exit.png', false)
        image_active = Gosu::Image.new($window, '../resources/menu/exit_selected.png', false)
        action = lambda { exit }
        return Imperium::DataModels::MenuSceneElementDataModel.new(area, image_active, image_normal, action)
      end
    end
  end
end