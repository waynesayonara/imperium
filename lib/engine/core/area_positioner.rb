require_relative 'point'
require_relative 'area'

module Engine
  # Helper class for calculating
  # top point of area on the screen/scene/window
  # according to preset conditions
  # supports:
  # - vertical/horizontal centering
  # - anchoring target area to top/bottom/left/right
  # - setting offsets to all four sides of the canvas
  class AreaPositioner
    private
    @canvas_width
    @canvas_height

    @area_width
    @area_height

    @top_offset
    @bottom_offset
    @left_offset
    @right_offset

    @vertical_align
    @horizontal_align

    protected
    def initialize(canvas_width, canvas_height)
      if(canvas_width.nil? || !canvas_width.is_a?(Integer) || canvas_width < 0)
        raise ArgumentError.new 'Canvas width only accepts positive integers.'
      end
      if(canvas_height.nil? || !canvas_height.is_a?(Integer) || canvas_height < 0)
        raise ArgumentError.new 'Canvas height only accepts positive integers.'
      end

      #setting defaults
      @canvas_height = canvas_height
      @canvas_width = canvas_width
      @area_width = 0
      @area_height = 0
      @top_offset = 0
      @bottom_offset = 0
      @left_offset = 0
      @right_offset = 0
      @vertical_align = :top
      @horizontal_align = :left
    end

    public
    # width of the area
    # to calculate position for
    def area_width(area_width)
      if(area_width.nil? || !area_width.is_a?(Integer) || area_width < 0)
        raise ArgumentError.new 'Area width only accepts positive integers.'
      end

      @area_width = area_width
      return self
    end

    # height of the area
    # to calculate position for
    def area_height(area_height)
      if(area_height.nil? || !area_height.is_a?(Integer) || area_height < 0)
        raise ArgumentError.new 'Area height only accepts positive integers.'
      end

      @area_height = area_height
      return self
    end

    # top offset of the canvas
    def top_offset(top_offset)
      if(top_offset.nil? || !top_offset.is_a?(Integer) || top_offset < 0)
        raise ArgumentError.new 'Top offset only accepts positive integers.'
      end

      @top_offset = top_offset
      return self
    end

    # bottom offset of the canvas
    def bottom_offset(bottom_offset)
      if(bottom_offset.nil? || !bottom_offset.is_a?(Integer) || bottom_offset < 0)
        raise ArgumentError.new 'Bottom offset only accepts positive integers.'
      end

      @bottom_offset = bottom_offset
      return self
    end

    # left offset of the canvas
    def left_offset(left_offset)
      if(left_offset.nil? || !left_offset.is_a?(Integer) || left_offset < 0)
        raise ArgumentError.new 'Bottom offset only accepts positive integers.'
      end

      @left_offset = left_offset
      return self
    end

    # right offset of the canvas
    def right_offset(right_offset)
      if(right_offset.nil? || !right_offset.is_a?(Integer) || right_offset < 0)
        raise ArgumentError.new 'Right offset only accepts positive integers.'
      end

      @right_offset = right_offset
      return self
    end

    # set vertical alignment to top
    def align_top
      @vertical_align = :top
      return self
    end

    # set vertical alignment to bottom
    def align_bottom
      @vertical_align = :bottom
      return self
    end

    # set vertical alignment to center
    def center_vertically
      @vertical_align = :center
      return self
    end

    # set horizontal alignment to center
    def center_horizontally
      @horizontal_align = :center
      return self
    end

    # set horizontal alignment to left
    def align_left
      @horizontal_align = :left
      return self
    end

    # set horizontal alignment to right
    def align_right
      @horizontal_align = :right
      return self
    end

    # calculates target resulting area
    # according to all preset conditions
    def get_area
      return Engine::Area.new(calculate_top_point_internal, @area_width, @area_height)
    end

    # calculates top point of target resulting area
    # according to all preset conditions
    def get_top_point
      return calculate_top_point_internal
    end

    private
    def calculate_top_point_internal
      top_point_x = -1
      top_point_y = -1

      case @horizontal_align
        when :left
          top_point_x = @left_offset
        when :center
          available_width = @canvas_width - @right_offset - @left_offset
          h_centering_offset = (available_width / 2) - (@area_width / 2)
          top_point_x = @left_offset + h_centering_offset
        when :right
          top_point_x = @canvas_width - @right_offset - @area_width
      end

      case @vertical_align
        when :top
          top_point_y = @top_offset
        when :center
          available_height = @canvas_height - @top_offset - @bottom_offset
          v_centering_offset = (available_height / 2) - (@area_height / 2)
          top_point_y = @top_offset + v_centering_offset
        when :bottom
          top_point_y = @canvas_height - @bottom_offset - @area_height
      end

      return Engine::Point.new(top_point_x, top_point_y)
    end
  end
end
