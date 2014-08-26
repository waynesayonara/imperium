require 'logger'

module Imperium
  module Log
    class GameLogger < Logger

      attr_reader :module_name

      def initialize(level, module_name)
        super(level)
        @module_name = module_name
        self.formatter =  proc do |severity, datetime, progname, msg|
          "#{Time.now} [#{severity}]: #{module_name} module: #{msg}\n"
        end
      end

    end
  end
end