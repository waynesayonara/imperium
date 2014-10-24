
module Imperium
  module DataModels
    class MenuSceneDataModelFactory
      private
      MENU_ELEMENTS_X_MARGIN = 280
      MENU_ELEMENTS_Y_MARGIN = 300
      MENU_ELEMENTS_WIDTH = 464
      MENU_ELEMENTS_HEIGHT = 95

      public
      def self.create_start_menu_data_model
        menu_elements =
            {
            'new_game' => create_new_game_element_data_model(0),
            'load_game' => create_load_game_element_data_model(150),
            'exit' => create_exit_game_element_data_model(300)
            }
        background = Gosu::Image.new($window, '../resources/menu/Imperium_splash_1024_800.png', false)

        return Engine::DataModels::MenuSceneDataModel.new(background, menu_elements)
      end

      def self.create_resume_game_menu_data_model
        menu_elements =
            {
                'resume_game' => create_resume_game_element_data_model(100),
                'exit' => create_exit_game_element_data_model(250)
            }
        background = Gosu::Image.new($window, '../resources/menu/Imperium_splash_1024_800.png', false)

        return Engine::DataModels::MenuSceneDataModel.new(background, menu_elements)
      end

      class << self
        private
        def create_resume_game_element_data_model(offset)
          area = create_menu_element_area(offset)
          image_normal = Gosu::Image.new($window, '../resources/menu/new_game.png', false)
          image_active = Gosu::Image.new($window, '../resources/menu/new_game_selected.png', false)
          action = lambda { $window.pop_scene }
          return Engine::DataModels::MenuSceneElementDataModel.new(area, image_active, image_normal, action)
        end

        def create_new_game_element_data_model(offset)
          area = create_menu_element_area(offset)
          image_normal = Gosu::Image.new($window, '../resources/menu/new_game.png', false)
          image_active = Gosu::Image.new($window, '../resources/menu/new_game_selected.png', false)
          action = lambda { $window.push_scene(Imperium::GameScene.new(Engine::Game.load_game_from_map(Engine::Map::TEST_PATH))) }
          return Engine::DataModels::MenuSceneElementDataModel.new(area, image_active, image_normal, action)
        end

        def create_load_game_element_data_model(offset)
          area = create_menu_element_area(offset)
          image_normal = Gosu::Image.new($window, '../resources/menu/load_game.png', false)
          image_active = Gosu::Image.new($window, '../resources/menu/load_game_selected.png', false)
          action = lambda { puts 'Not Implemented!' }
          return Engine::DataModels::MenuSceneElementDataModel.new(area, image_active, image_normal, action)
        end

        def create_exit_game_element_data_model(offset)
          area = create_menu_element_area(offset)
          image_normal = Gosu::Image.new($window, '../resources/menu/exit.png', false)
          image_active = Gosu::Image.new($window, '../resources/menu/exit_selected.png', false)
          action = lambda { exit }
          return Engine::DataModels::MenuSceneElementDataModel.new(area, image_active, image_normal, action)
        end

        def create_menu_element_area(offset)
          top_point = Engine::Point.new(MENU_ELEMENTS_X_MARGIN, MENU_ELEMENTS_Y_MARGIN + offset)
          return Engine::Area.new(top_point, MENU_ELEMENTS_WIDTH, MENU_ELEMENTS_HEIGHT)
        end
      end
    end
  end
end