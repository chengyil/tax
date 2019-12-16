module Tax
  module Cli
    class App
      def run
        config = parse
        Tax.config.merge!(config)
        handle_trap
        console = Tax::Console.new(STDIN)
        console.run
      end

      def handle_trap
        %w(TERM SIGINT).each do |signal|
          Signal.trap(signal) do
            exit 0
          end
        end
      end

      def parse(param=ARGV)
        @parsed_config ||= {}
      end
    end
  end
end
