require_relative '../../../../../lib/imperium'

module Imperium
  class MenuScene
    include Imperium::Scene

    def initialize(data_model)
      self.data_model_type = Imperium::DataModels::MenuSceneDataModel
      self.data_model = data_model

      self.data_model.menu_elements.values.each do |elem|
        control = Imperium::MenuElementControl.new(elem)
        add_control(control)
      end
    end

    # this method will be called from main window
    # it describes how concrete scene impl
    # should be rendered on a screen
    def render_scene
      self.data_model.background.draw(0, 0, 0)

      ui_controls.each do |control|
        control.render_control
      end
    end

    def on_button_up(button_id, point)
      if(button_id == Gosu::KbSpace)
        $window.pop_scene
      end
    end
  end
end
