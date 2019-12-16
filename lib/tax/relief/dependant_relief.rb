module Tax
  module Relief
    class Dependant
      include Relief
      def self.qualified?(param={})
        tax_payer = param[:tax_payer]
        tax_payer.single? || tax_payer.married?
      end

      attr_reader :tax_payer

      def initialize(param={})
        @tax_payer = param[:tax_payer] 
      end

      def amount
        if tax_payer.married?
          case tax_payer.dependant
          when 0
            58500000
          when 1
            63000000
          when 2
            67000000
          else
            72000000
          end
        else
          54000000
        end
      end
    end
  end
end
