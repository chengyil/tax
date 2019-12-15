module Tax
  class Console
    attr_reader :client, :io

    def initialize(io)
      @io = io
    end

    def run
      header
      while(input = io.gets)
        execute(input.strip.downcase)
      end
    end

    private

    # Formatter
    # main header
    def header
      console('Welcome to Individual Income Tax Calculator')
      console('1. Calculate Individual Income')
      console('2. Exit')
      console('Enter options')
    end

    def execute(input)
      case input
      when '1'
        Tax::Console::IndividualTax.new(io).run
        header
      when '2'
        console 'Thank you'
        logger.info 'Thank you'
        exit 0
      else
        header
      end
    end

    def console(out)
      STDOUT.puts out
    end

    def logger
      Tax.logger
    end
  end
end
require_relative 'console/individual_tax.rb'
