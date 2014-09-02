require_relative '../../../../lib/imperium'

module Imperium
  module MouseCoordinator
    @controls

    def ui_controls
      if(@controls.nil?)
        @controls = []
      end
      @controls
    end

    def add_control(new_control)
      if(new_control.nil? || !new_control.is_a?(Imperium::Control))
        raise ArgumentError.new "New control must be a non-nil descendant of #{Imperium::Control}"
      end

      if(ui_controls.include?(new_control))
        raise ArgumentError.new 'Cannot add control twice'
      end

      ui_controls << new_control
    end

    def remove_control(control)
      ui_controls.delete(control)
    end

    protected
    def process_movement(mouse_x, mouse_y)
      ui_controls.each do |control|
        if(is_coord_inside_area(mouse_x, mouse_y, control.x, control.y, control.width, control.height))
          control.hover(true)
        elsif(control.is_active)
          control.hover(false)
        end
      end

    end

    def process_click(button_id, mouse_x, mouse_y)
    end

    protected
    def is_coord_inside_area(coord_x, coord_y, area_top_x, area_top_y, area_width, area_height)
      if(coord_x.nil? || coord_y.nil? || area_top_x.nil? || area_top_y.nil? || area_height.nil? || area_width.nil?)
        raise ArgumentError.new 'Cannot calculate with nil arguments'
      end

      if(coord_x < 0 || coord_y < 0 || area_top_x < 0 || area_top_y < 0 || area_height < 0 || area_width < 0)
        raise ArgumentError.new 'Cannot calculate with negative arguments'
      end

      if(coord_x > area_top_x && coord_x < area_top_x + area_width &&
         coord_y > area_top_y && coord_y < area_top_y + area_height)
        return true
      else
        return false
      end
    end
  end
end