module Tax
  module Cli
    class App
      def run
        config = parse
        Tax.config.merge!(config)
        validate
        handle_trap
        console = Tax::Console.new(STDIN)
        console.run
      end

      private

      def validate
        if Tax.config.tax_rates.nil?
          raise ConfigError, "tax rate config file is missing #{config_path.join('tax_rates.yml')}"
        end
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
