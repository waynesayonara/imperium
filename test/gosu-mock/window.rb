require 'set'

# Originally from the gosu-mock project
# https://bitbucket.org/philomory/gosu-mock/overview
module GosuMock
  class Window
    # Methods present in Gosu
    attr_reader :width, :height, :update_interval, :mouse_x, :mouse_y
    def initialize(width,height,fullscreen,update_interval=1.0/60.0)
      @width, @height = width, height
      @fullscreen = fullscreen
      @update_interval = update_interval
      @buttons_depressed = Set.new
      @button_down_events = []
      @button_up_events = []
      @drawing_events = []
      @loaded_images = []
      @loaded_fonts = []
      @mouse_x, @mouse_y = 0,0
    end

    # stubbed out so that methods not needed for particular tests won't cause crashes.
    def update; end
    def draw; end
    def button_down(id); end
    def button_up(id); end
   
    def button_down?(id)
      @buttons_depressed.include?(id)
    end


    # Methods for manipulating the test.
    def do_tick
      handle_input_events
      # TODO: handle audio
      update
      clean_slate
      draw
    end
    
    def user_presses_button(id)
      @buttons_depressed << id
      @button_down_events << id
    end
    
    def user_releases_button(id)
      @buttons_depressed.delete(id)
      @button_up_events << id
    end
    
    def user_moves_mouse_to(x,y)
      @mouse_x, @mouse_y = x, y
    end
    
    #methods for getting info about the test.
    attr_reader :drawing_events
    
    #methods called by other mock classes
    def image_added(image)
      @loaded_images << image
    end
    
    private
    def clean_slate
      @drawing_events.clear
      @loaded_images.each {|image| image.drawing_events.clear }
    end
    
    def handle_input_events
      @button_down_events.each {|id| button_down(id)}
      @button_down_events.clear
      
      @button_up_events.each {|id| button_up(id)}
      @button_up_events.clear
    end
    
    
  end
end