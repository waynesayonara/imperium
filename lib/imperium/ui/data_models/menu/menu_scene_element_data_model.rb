require_relative '../../../../imperium'

module Imperium
  module DataModels
    class MenuSceneElementDataModel
      @area
      @image_active
      @image_normal
      @action

      def initialize(area, image_active, image_normal, action)
        if(area.nil? || !area.is_a?(Imperium::Area))
          raise ArgumentError.new "Argument area should be a non-nil instance of #{Imperium::Area}"
        end

        if(image_active.nil? || !image_active.is_a?(Gosu::Image))
          raise ArgumentError.new "Argument image_active should be a non-nil instance of #{Gosu::Image}"
        end

        if(image_normal.nil? || !image_normal.is_a?(Gosu::Image))
          raise ArgumentError.new "Argument image_normal should be a non-nil instance of #{Gosu::Image}"
        end

        if(action.nil? || !action.respond_to?(:call))
          raise ArgumentError.new 'Argument action should be a non-nil lambda-block'
        end

        @area = area
        @image_active = image_active
        @image_normal = image_normal
        @action = action
      end

      # Area of menu element
      # hover & click event will be captured
      # according to this area's coordinates
      def area
        @area
      end

      # Active image
      # This image will be rendered when
      # particular menu element is selected
      def image_active
        @image_active
      end

      # Normal image
      # This image will be rendered when
      # particular menu element is in its
      # normal state
      def image_normal
        @image_normal
      end

      # OnClick action
      # This lambda will be called
      # when this menu element receives
      # click event
      def action
        @action
      end
    end
  end
end
