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
    def process_movement(point)
      if(point.nil? || !point.is_a?(Imperium::Point))
        raise ArgumentError.new "Argument can only be a non-nil instance of #{Imperium::Point}"
      end

      ui_controls.each do |control|
        if(control.area.includes?(point))
          control.hover(true)
        elsif(control.is_active)
          control.hover(false)
        end
      end

    end

    def process_click(button_id, point)
      if(point.nil? || !point.is_a?(Imperium::Point))
        raise ArgumentError.new "Argument can only be a non-nil instance of #{Imperium::Point}"
      end
    end
  end
end