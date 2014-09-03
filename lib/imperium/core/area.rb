require_relative '../../../lib/imperium'

module Imperium
  class Area
    @top_point
    @width
    @height

    def initialize(top_point, width, height)
      if(width.nil? || !width.is_a?(Integer) || width < 0)
        raise ArgumentError.new 'Width can only be a positive integer.'
      end
      if(height.nil? || !height.is_a?(Integer) || height < 0)
        raise ArgumentError.new 'Height can only be a positive integer.'
      end
      if(top_point.nil? || !top_point.is_a?(Imperium::Point))
        raise ArgumentError.new "Top point can only be a non-nil instance of #{Imperium::Point}"
      end

      @top_point = top_point
      @width = width
      @height = height
    end

    # Top point (coordinates) of the area
    def top_point
      @top_point
    end

    def top_point=(value)
      if(value.nil? || !value.is_a?(Imperium::Point))
        raise ArgumentError.new "Top point can only be a non-nil instance of #{Imperium::Point}"
      end

      @top_point = value
    end

    # Width
    def width
      @width
    end

    def width=(value)
      if(value.nil? || !value.is_a?(Integer) || value < 0)
        raise ArgumentError.new 'Width can only be a positive integer.'
      end

      @width = value
    end

    # Height
    def height
      @height
    end

    def height=(value)
      if(value.nil? || !value.is_a?(Integer) || value < 0)
        raise ArgumentError.new 'Height can only be a positive integer.'
      end

      @height = value
    end

    def includes?(point)
      if(point.nil? || !point.is_a?(Imperium::Point))
        raise ArgumentError.new "Argument can only be a non-nil instance of #{Imperium::Point}"
      end

      if(point.x >= @top_point.x && point.x <= @top_point.x + @width &&
          point.y >= @top_point.y && point.y <= @top_point.y + @height)
        return true
      else
        return false
      end
    end
  end
end
