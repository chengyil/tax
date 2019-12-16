module Tax
  module Assessment
    class Individual
      attr_reader :tax_payer

      def initialize(tax_payer: nil)
        @tax_payer = tax_payer
      end

      def assessable_income
        relief = reliefs.reduce(0) { |sum, entry| sum += entry.amount}
        @assessable_income ||= total_income - relief > 0 ? total_income - relief : 0
      end
      
      def total_payable
        tax_payable.reduce(0) { |sum, payable| sum += payable.amount }
      end

      def tax_payable
        return @tax_payable if @tax_payable

        income = assessable_income
        @taxpayable = []

        if income < 50000000
          payable = income * 0.05
          @taxpayable << Tax::Entry::TaxPayable.new(type: 'Tax Payable', amount: payable, description: 'Tax on first %s' % income)
          income = 0 
        else
          income -= 50000000
          payable = 50000000 * 0.05
          @taxpayable << Tax::Entry::TaxPayable.new(type: 'Tax Payable', amount: payable, description: 'Tax on first 50.000.000 IDR')
        end

        if income > 0 && income < 200000000 
          payable = income * 0.15
          @taxpayable << Tax::Entry::TaxPayable.new(type: 'Tax Payable', amount: payable, description: 'Tax on next %s' % income)
          income = 0 
        elsif income > 0 && income >= 200000000 
          income -= 200000000
          payable = 200000000 * 0.15
          @taxpayable << Tax::Entry::TaxPayable.new(type: 'Tax Payable', amount: payable, description: 'Tax on next 200.000.000 IDR')
        end

        if income > 0 && income < 250000000 
          payable = income * 0.25
          @taxpayable << Tax::Entry::TaxPayable.new(type: 'Tax Payable', amount: payable, description: 'Tax on next %s' % income)
          income = 0 
        elsif income > 0 && income >= 250000000 
          income -= 250000000
          payable = 250000000 * 0.25
          @taxpayable << Tax::Entry::TaxPayable.new(type: 'Tax Payable', amount: payable, description: 'Tax on next 250.000.000 IDR')
        end

        if income > 0
          payable = income * 0.30
          @taxpayable << Tax::Entry::TaxPayable.new(type: 'Tax Payable', amount: payable, description: 'Tax on next %s' % income)
          income = 0 
        end
        @taxpayable
      end

      # TODO
      # Extractable
      def report
        console "Total income : #{total_income}"
        reliefs.each do |relief|
          console "%s %s %s" % [relief.type, relief.amount, relief.description]
        end
        console "Assessable income : #{assessable_income}"
        tax_payable.each do |payable|
          console "%s: %s, %s" % [payable.type, payable.amount, payable.description]
        end
        console "Payable Tax : %s" % total_payable
      end

      private

      def console(out)
        STDOUT.puts out
      end

      def total_income
        tax_payer.total_income.to_idr
      end

      def reliefs
        @reliefs ||= Tax::Relief.qualified_relief(tax_payer: tax_payer).map(&:amount)
      end
    end
  end
end
