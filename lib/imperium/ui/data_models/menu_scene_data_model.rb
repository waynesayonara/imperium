require_relative '../../../../lib/imperium'

module Imperium
  module DataModels
    class MenuSceneDataModel
      private
      attr_writer :background, :menu_elements

      public
      attr_reader :background, :menu_elements

      def initialize(background, menu_elements)
        raise ArgumentError.new 'Input menu elements cannot be nil' if menu_elements.nil?
        raise ArgumentError.new 'Input background cannot be nil' if background.nil?

        if !menu_elements.is_a?(Hash) || menu_elements.empty?
          raise ArgumentError.new 'Input menu elements must represent a non-empty hash'
        end

        unless menu_elements.values.all? { |v| v.is_a?(Imperium::DataModels::MenuSceneElementDataModel) }
          raise ArgumentError.new "Input menu elements must be of type #{Imperium::DataModels::MenuSceneElementDataModel}"
        end

        self.background = background
        self.menu_elements = menu_elements
      end
    end
  end
end
