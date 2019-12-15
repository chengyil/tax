module Tax
  module Cli
    class App
      def run
        config = parse
        Tax.config.merge!(config)
        console = Tax::Console.new(STDIN)
        console.run
      end

      def parse(param=ARGV)
        @parsed_config ||= {}
      end
    end
  end
end
