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
        @taxpayable = []
        tax_rates.each_index do |index|
          bucket = tax_rates[index]
          min = bucket[:min].to_idr
          max = bucket[:max].to_idr if bucket[:max]
          if assessable_income > min
            logger.info "Current Bucket is : #{bucket}, assessable_income is #{assessable_income}"
            if bucket[:max].nil? || assessable_income <= max
              current_assessable = assessable_income - min
            elsif bucket[:max] && assessable_income > max
              current_assessable = max - min
            end
            current_payable = current_assessable * bucket[:rate]
            logger.info "Current payable for bucket is : #{current_payable} from #{current_assessable} with rate of #{bucket[:rate]}"
            if index.zero?
              @taxpayable << Tax::Entry::TaxPayable.new(type: 'Tax Payable', amount: current_payable, description: 'Tax on first %s' % current_assessable)
            else
              @taxpayable << Tax::Entry::TaxPayable.new(type: 'Tax Payable', amount: current_payable, description: 'Tax on next %s' % current_assessable)
            end
          end
        end

        @taxpayable
      end

      # TODO
      # Extractable
      def report
        output = StringIO.new
        output.puts "Total income : #{total_income}"
        reliefs.each do |relief|
          output.puts "%s %s %s" % [relief.type, relief.amount, relief.description]
        end
        output.puts "Assessable income : #{assessable_income}"
        tax_payable.each do |payable|
          output.puts "%s: %s, %s" % [payable.type, payable.amount, payable.description]
        end
        output.puts "Payable Tax : %s" % total_payable
        output.rewind
        output.read
      end

      private

      def tax_rates
        Tax.config.tax_rates[:tax_rates]
      end

      def total_income
        tax_payer.total_income.to_idr
      end

      def reliefs
        @reliefs ||= Tax::Relief.qualified_relief(tax_payer: tax_payer).map(&:entry)
      end
    end
  end
end
