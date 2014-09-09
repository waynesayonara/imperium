require_relative '../../../lib/imperium'

module Imperium
  class Point
    @x
    @y

    def initialize(x, y)
      if(x.nil? || !x.is_a?(Integer) || x < 0)
        raise ArgumentError.new 'Point coordinate only accepts positive integers.'
      end
      if(y.nil? || !y.is_a?(Integer) || y < 0)
        raise ArgumentError.new 'Point coordinate only accepts positive integers.'
      end

      @x = x
      @y = y
    end

    # X-axis coordinate
    def x
      @x
    end

    # X-axis coordinate setter
    def x=(value)
      if(value.nil? || !value.is_a?(Integer) || value < 0)
        raise ArgumentError.new 'Point coordinate only accepts positive integers.'
      end

      @x = value
    end

    # Y-axis coordinate
    def y
      @y
    end

    # Y-axis coordinate setter
    def y=(value)
      if(value.nil? || !value.is_a?(Integer) || value < 0)
        raise ArgumentError.new 'Point coordinate only accepts positive integers.'
      end

      @y = value
    end

    def ==(another_point)
      return self.x == another_point.x && self.y == another_point.y
    end
  end
end
