module Tax
  class Console
    class IndividualTax
      attr_reader :io

      def initialize(io)
        @io = io
      end

      def run
        if monthly_income.nil?
        end
      end

      private

      attr_accessor :monthly_income

      def header
      end
    end
  end
end
