require_relative '../../../../lib/imperium'

module Imperium
  module Scene
    @prev_mouse_position

    @data_model
    @controls

    public
    attr_accessor :data_model_type

    # Data model
    def data_model
      @data_model
    end

    # Data model setter
    def data_model=(model)
      raise ArgumentError.new 'Input data model value cannot be nil' if model.nil?
      raise ArgumentError.new 'Data model type cannot be nil at this point' if data_model_type.nil?
      raise TypeError.new "Cannot assign data model which is not compatible with data model type: [#{data_model_type}]" unless model.is_a?(data_model_type)

      @data_model = model
    end

    # Collection of underlying controls
    def ui_controls
      if(@controls.nil?)
        @controls = []
      end
      @controls
    end

    # Adds control to collection
    # Raises exception if control is already in
    def add_control(new_control)
      if(new_control.nil? || !new_control.is_a?(Imperium::Control))
        raise ArgumentError.new "New control must be a non-nil descendant of #{Imperium::Control}"
      end

      if(ui_controls.include?(new_control))
        raise ArgumentError.new 'Cannot add control twice'
      end

      ui_controls << new_control

      new_control.render_control
    end

    # Removes control from collection
    def remove_control(control)
      ui_controls.delete(control)
    end

    def button_up(id, point)
      if(point.nil? || !point.is_a?(Imperium::Point))
        raise ArgumentError.new "Argument can only be a non-nil instance of #{Imperium::Point}"
      end

      if(id.nil?)
        raise ArgumentError.new 'Button Id cannot be nil'
      end

      process_button_up(id, point)
      on_button_up(id, point)
    end

    def button_down(id, point)
      if(point.nil? || !point.is_a?(Imperium::Point))
        raise ArgumentError.new "Argument can only be a non-nil instance of #{Imperium::Point}"
      end

      if(id.nil?)
        raise ArgumentError.new 'Button Id cannot be nil'
      end

      process_button_down(id, point)
      on_button_down(id, point)
    end

    # this method will be called from main window
    # it describes how concrete scene impl
    # should be rendered on a screen
    def render_scene
      raise NotImplementedError.new 'Must be overridden in derived classes'
    end

    def update(point)
      if(@prev_mouse_position.nil? || @prev_mouse_position != point)
        @prev_mouse_position = Imperium::Point.new(point.x, point.y)
        process_movement(point)
        on_mouse_move(point)
      end

      on_update(point)
    end

    # Might be overridden for cursorless scenes
    def needs_cursor?
      return true
    end

    protected
    # Derived classes should call method whenever
    # mouse movement have to be processed
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

    # Derived classes should call method whenever
    # button up event have to be processed
    def process_button_down(button_id, point)
      ui_controls.each do |control|
        if(control.area.includes?(point))
          control.button_down(button_id, point)
        end
      end
    end

    # Derived classes should call method whenever
    # button down event have to be processed
    def process_button_up(button_id, point)
      ui_controls.each do |control|
        if(control.area.includes?(point))
          control.button_up(button_id, point)
        end
      end
    end

    # Custom handler for button_up on the WHOLE scene
    # Can be overridden in derived classes
    def on_button_up(button_id, point)
    end

    # Custom handler for button_down on the WHOLE scene
    # Can be overridden in derived classes
    def on_button_down(button_id, point)
    end

    # Custom handler for mouse_move on the WHOLE scene
    # Can be overridden in derived classes
    def on_mouse_move(new_point)
    end

    # Custom handler for update on the WHOLE scene
    # Can be overridden in derived classes
    def on_update(new_point)
    end
  end
end