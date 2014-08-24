# Originally from the gosu-mock project
# https://bitbucket.org/philomory/gosu-mock/overview
module GosuMock
  class Image
    class << self
      attr_writer :default_image_width, :default_image_height
      def default_image_width
        @default_image_width || 20
      end
      def default_image_height
        @default_image_height || 20
      end
    end

    # methods provided by Gosu::Image
    def initialize(window, filename_or_rmagick_image, tileable, src_x=0, src_y=0, src_width=nil, src_height=nil)
      @window = window
      @tileable = tileable
      @src_x, @src_y = src_x, src_y
      @width, @height = src_width, src_height
      if filename_or_rmagick_image.respond_to?(:to_blob)
        setup_via_rmagic(filename_or_rmagick_image)
      elsif filename_or_rmagick_image.respond_to?(:to_str)
        setup_via_filename(filename_or_rmagick_image.to_str)
      else
        raise(ArgumentError, 'Second argument must be either a filename or an object which responds to :to_blob.')
      end
      @drawing_events = []
      @window.image_added(self)
    end
    
    def draw(x,y,z,factor_x=1,factor_y=1,color=0xFFFFFFFF,mode=:default)
      event = DrawingEvent.new(
          self,
          :normal,
          {
            :x=> x,
            :y=> y,
            :z=> z,
            :factor_x=> factor_x,
            :factor_y=> factor_y,
            :color=> color,
            :mode=> mode
          })
      @drawing_events << event
      @window.drawing_events << event
    end
    
    def draw_as_quad(x1, y1, c1, x2, y2, c2, x3, y3, c3, x4, y4, c4, z, mode=:default)
      event = DrawingEvent.new(
          self,
          :quad,
          {
            :x1=> x1,
            :y1=> y1,
            :c1=> c1,
            :x2=> x2,
            :y2=> y2,
            :c2=> c2,
            :x3=> x3,
            :y3=> y3,
            :c3=> c3,
            :x4=> x4,
            :y4=> y4,
            :c4=> c4,
            :z=> z,
            :mode=>mode
          })
      @drawing_events << event
      @window.drawing_events << event
    end
    
    def draw_rot(x,y,z,angle,center_x=0.5,center_y=0.5,factor_x=1,factor_y=1,color=0xFFFFFFFF,mode=:default)
      event = DrawingEvent.new(
          self,
          :rot,
          {
              :x=> x,
              :y=> y,
              :z=> z,
              :angle=> angle,
              :center_x=> center_x,
              :center_y=> center_y,
              :factor_x=> factor_x,
              :factor_y=> factor_y,
              :color=> color,
              :mode=> mode
          })
      @drawing_events << event
      @window.drawing_events << event
    end

    
    # Methods for testing
    attr_reader :drawing_events, :filename, :data, :label
    
    
    private
    def setup_via_filename(filename)
      @filename = filename
      @label = "from file: #{filename}"
      @width = Image.default_image_width
      @height = Image.default_image_height
    end
    
    def setup_via_rmagic(image)
      @data = image.to_blob
      @label = "from blob: #{image.id}"
      @width ||= image.columns - src_x
      @height ||= image.rows - src_y
    end
  end
end