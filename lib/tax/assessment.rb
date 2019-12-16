module Tax
  module Assessment
    class Individual
      attr_reader :tax_payer

      def initialize(tax_payer: nil)
        @tax_payer = tax_payer
      end

      def assessable_income
        @assessable_income ||= total_income - relief > 0 ? total_income - relief : 0
      end

      def tax_payable
        income = assessable_income
        taxpayable = 0
        taxpayable += if income < 50000000
                        payable = income * 0.05
                        income = 0 
                        payable
                      else
                        income -= 50000000
                        50000000 * 0.05
                      end

        taxpayable += if income > 0 && income < 200000000 
                        payable = income * 0.15
                        income = 0 
                        payable
                      elsif income > 0 && income >= 200000000 
                        income -= 200000000
                        200000000 * 0.15
                      else
                        0
                      end

        taxpayable += if income > 0 && income < 250000000 
                        payable = income * 0.25
                        income = 0 
                        payable
                      elsif income > 0 && income >= 250000000 
                        income -= 250000000
                        250000000 * 0.25
                      else
                        0
                      end

        taxpayable += if income > 0
                        payable = income * 0.30
                        income = 0 
                        payable
                      else
                        0
                      end
        taxpayable
      end

      private

      def total_income
        tax_payer.total_income
      end

      def relief
        Tax::Relief.qualified_relief(tax_payer: tax_payer).reduce(0) do |amount, relief|
          amount += relief.amount
        end
      end
    end
  end
end
