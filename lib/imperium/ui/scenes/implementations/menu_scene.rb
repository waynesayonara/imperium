require_relative '../../../../../lib/imperium'

module Imperium
  class MenuScene
    include Imperium::Scene

    def initialize(data_model)
      self.data_model_type = Imperium::DataModels::MenuSceneDataModel
      self.data_model = data_model
    end

    # this method will be called from main window
    # it describes how concrete scene impl
    # should be rendered on a screen
    def render_scene(window)
      data_model.each do |elem|
        window.font.draw elem.text, elem.x, elem.y, 0
      end
    end
  end
end
