require_relative '../../../../lib/imperium'

module Imperium
  module Control
    @is_active
    @x
    @y
    @height
    @width

    def height
      @height
    end

    def height=(value)
      if(value < 0)
        raise ArgumentError.new 'value cannot be negative'
      end
      @height = value
    end

    def width
      @width
    end

    def width=(value)
      if(value < 0)
        raise ArgumentError.new 'value cannot be negative'
      end
      @width = value
    end

    def y
      @y
    end

    def y=(value)
      if(value < 0)
        raise ArgumentError.new 'value cannot be negative'
      end
      @y = value
    end

    def x
      @x
    end

    def x=(value)
      if(value < 0)
        raise ArgumentError.new 'value cannot be negative'
      end
      @x = value
    end

    def is_active
      if(@is_active.nil?)
        @is_active = false
      end
      @is_active
    end

    protected
    def is_active=(active)
      if(active != true && active != false)
        raise ArgumentError.new "#{active} is not recognized a as boolean value"
      end
      @is_active = active
    end

    # Can be overridden in derived classes
    public
    def click(button_id)
      on_click(button_id)
    end

    # Can be overridden in derived classes
    def mouse_up(button_id)
      self.is_active= false
      self.on_mouse_up(button_id)
    end

    # Can be overridden in derived classes
    def mouse_down(button_id)
      self.is_active= true
      self.on_mouse_down(button_id)
    end

    # Can be overridden in derived classes
    def hover(is_on)
      self.is_active=is_on

      if(is_on)
        on_hover_activated
      else
        on_hover_deactivated
      end
    end

    protected
    def on_hover_activated
    end

    def on_hover_deactivated
    end

    def on_mouse_up(button_id)
    end

    def on_mouse_down(button_id)
    end

    def on_click(button_id)
    end
  end
end

