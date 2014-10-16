
module Engine
  module Control
    @is_active
    @area

    def area
      @area
    end

    def area=(value)
      if(value.nil? || !value.is_a?(Engine::Area))
        raise ArgumentError.new "Argument can only be a non-nil instance of #{Engine::Area}"
      end

      @area = value
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

    public
    def button_up(button_id, point)
      self.is_active= false
      self.on_button_up(button_id, point)
    end

    def button_down(button_id, point)
      self.is_active= true
      self.on_button_down(button_id, point)
    end

    def hover(is_on)
      self.is_active=is_on

      if(is_on)
        on_hover_activated
      else
        on_hover_deactivated
      end
    end

    # Draws control
    def render_control
      raise NotImplementedError.new 'Must be overridden in derived classes'
    end

    # Can be overridden in derived classes
    protected
    def on_hover_activated
    end

    # Can be overridden in derived classes
    def on_hover_deactivated
    end

    # Can be overridden in derived classes
    def on_button_up(button_id, point)
    end

    # Can be overridden in derived classes
    def on_button_down(button_id, point)
    end
  end
end

