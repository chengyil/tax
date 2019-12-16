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

      def entry
        if tax_payer.married?
          case tax_payer.dependant
          when 0
            Tax::Entry::Relief.new(amount: 58500000, type: 'Dependant Relief', description: 'Married with no dependant')
          when 1
            Tax::Entry::Relief.new(amount: 63000000, type: 'Dependant Relief', description: 'Married with 1 dependant')
          when 2
            Tax::Entry::Relief.new(amount: 67000000, type: 'Dependant Relief', description: 'Married with 2 dependants')
          else
            Tax::Entry::Relief.new(amount: 72000000, type: 'Dependant Relief', description: 'Married with 3 dependants')
          end
        else
          Tax::Entry::Relief.new(amount: 54000000, type: 'Dependant Relief', description: 'Single')
        end
      end
    end
  end
end
