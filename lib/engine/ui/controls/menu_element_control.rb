
module Engine
  class MenuElementControl
    include Engine::Control

    private
    @data_model
    @is_active

    protected
    def initialize(menu_scene_element)
      if(menu_scene_element.nil? || !menu_scene_element.is_a?(Imperium::DataModels::MenuSceneElementDataModel))
        raise ArgumentError.new "Argument can only be a non-nil instance of #{Imperium::DataModels::MenuSceneElementDataModel}"
      end

      @data_model = menu_scene_element
      @is_active = false
    end

    public
    def render_control
      target_image = @is_active ? @data_model.image_active : @data_model.image_normal
      target_image.draw(@data_model.area.top_point.x, @data_model.area.top_point.y, 0)
    end

    def area
      @data_model.area
    end

    def area=(value)
      @data_model.area = value
    end

    protected
    def on_hover_activated
      @is_active = true
    end

    def on_hover_deactivated
      @is_active = false
    end

    def on_button_up(button_id, point)
      if(button_id == Gosu::MsLeft)
        @data_model.action.call
      end
    end
  end
end
