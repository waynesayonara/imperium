require_relative '../../../../lib/imperium'

module Imperium
  class MenuElementControl
    include Imperium::Control

    @image_active
    @image_normal
    @click_action

    def initialize(menu_scene_element)
      if(menu_scene_element.nil? || !menu_scene_element.is_a?(Imperium::DataModels::MenuSceneElementDataModel))
        raise ArgumentError.new "Argument can only be a non-nil instance of #{Imperium::DataModels::MenuSceneElementDataModel}"
      end

      self.area= menu_scene_element.area
      @image_active = menu_scene_element.image_active
      @image_normal = menu_scene_element.image_normal
      @click_action = menu_scene_element.action
    end

    def render_control
      #TODO: implement
    end
  end
end
