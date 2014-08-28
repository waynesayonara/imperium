require_relative '../../../../lib/imperium'

module Imperium
  module Scene
    @data_model

    public
    attr_accessor :data_model_type

    def data_model
      @data_model
    end

    def data_model=(model)
      raise ArgumentError.new 'Input data model value cannot be nil' if model.nil?
      raise ArgumentError.new 'Data model type cannot be nil at this point' if data_model_type.nil?
      raise TypeError.new "Cannot assign data model which is not compatible with data model type: [#{data_model_type}]" unless model.is_a?(data_model_type)

      @data_model = model
    end

    def button_up(id)
      raise NotImplementedError.new 'Must be overridden in derived classes'
    end

    def button_down(id)
      raise NotImplementedError.new 'Must be overridden in derived classes'
    end

    # this method will be called from main window
    # it describes how concrete scene impl
    # should be rendered on a screen
    def render_scene
      raise NotImplementedError.new 'Must be overridden in derived classes'
    end

    def update
      raise NotImplementedError.new 'Must be overridden in derived classes'
    end

    # Might be overridden for cursorless scenes
    def needs_cursor?
      return true
    end
  end
end