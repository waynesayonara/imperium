module GosuMock
  # A font can be used to draw text on a Window object very flexibly.
  # Fonts are ideal for small texts that change regularly. For large,
  # static texts you should use {Gosu::Image#from_text}.
  class Font
    class << self
      attr_accessor :window, :font_name, :height

      ##
      # The font's name. This may be the name of a system font or a filename.
      #
      # @return [String] the font's name.
      attr_reader :name

      ##
      # @return [Fixnum] The font's height in pixels.
      attr_reader :height

      ##
      # Load a font from the system fonts or a file.
      #
      # @param window [Gosu::Window]
      # @param font_name [String] the name of a system font, or a path to a TrueType Font (TTF) file. A path must contain at least one '/' character to distinguish it from a system font.
      # @param height [Fixnum] the height of the font, in pixels.
      def initialize(window, font_name, height);
        window = window
        font_name = font_name
        height = height
      end

      # @!group Drawing text

      ##
      # Draws a single line of text with its top left corner at (x, y).
      #
      # @return [void]
      # @param text [String]
      # @param x [Number] the X coordinate
      # @param y [Number] the Y coordinate
      # @param z [Number] the Z-order.
      # @param factor_x [Float] the horizontal scaling factor.
      # @param factor_y [Float] the vertical scaling factor.
      # @param color [Color, Fixnum]
      # @param mode [:default, :additive] the blending mode to use.
      #
      # @see #draw_rel
      # @see Gosu::Image.from_text
      # @see file:reference/Drawing_with_Colors.md Drawing with Colors
      # @see file:reference/Z-Ordering.md
      def draw(text, x, y, z, factor_x=1, factor_y=1, color=0xffffffff, mode=:default);
      end

      ##
      # Draws a single line of text relative to (x, y).
      #
      # The text is aligned to the drawing location according to the `rel_x` and `rel_y` parameters: a value of 0.0 corresponds to top and left, while 1.0 corresponds to bottom and right. A value of 0.5 naturally corresponds to the center of the text.
      #
      # All real numbers are valid alignment values and will be interpolated (or extrapolated) accordingly.
      #
      # @return [void]
      # @param rel_x [Float] the horizontal alignment.
      # @param rel_y [Float] the vertical alignment.
      # @param (see #draw)
      #
      # @see #draw
      # @see file:reference/Drawing_with_Colors.md Drawing with Colors
      # @see file:reference/Z-Ordering.md
      def draw_rel(text, x, y, z, rel_x, rel_y, factor_x=1, factor_y=1, color=0xffffffff, mode=:default);
      end

      # @!endgroup
    end
  end
end