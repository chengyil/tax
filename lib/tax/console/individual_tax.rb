module Tax
  class Console
    class IndividualTax
      attr_reader :io, :tax_payer

      def initialize(io, tax_payer=Tax::Person.new)
        @io = io
        @tax_payer = tax_payer
      end

      def run
        tax_payer.monthly_income = get_monthly_income
        tax_payer.marital_status = get_marital_status
        if tax_payer.married?
          tax_payer.dependant = get_dependant
        end

        assessment = Tax::Assessment::Individual.new(tax_payer: tax_payer)
        console "Total income : #{tax_payer.total_income}"
        console "Assessable income : #{assessment.assessable_income}"
        console "Payable Tax : %d" % assessment.tax_payable

      end

      private
      attr_accessor :relief, :total_income, :assessable_income

      # TODO
      # Possible to extract this out
      # But what is this name
      def get_monthly_income
        monthly_income = nil
        while monthly_income.nil?  
          console 'What is your monthly income?'
          input = io.gets.strip
          if input.match? /\D+/
            console 'Please enter numeric value'
          else
            monthly_income = input.to_i 
          end
        end
        monthly_income
      end

      # TODO
      # Possible to extract this input retrival 
      def get_marital_status
        marital_status = nil
        while marital_status.nil?  
          console 'What is your marital status?'
          console '1. Single'
          console '2. Married'
          input = io.gets.strip
          case input
          when '1'
            marital_status = :single
          when '2'
            marital_status = :married
          when /\D+/
            console 'Please enter numeric value'
          else
            console 'Please enter 1 or 2'
          end
        end
        marital_status
      end

      def get_dependant
        dependant = nil
        while dependant.nil?  
          console 'How many dependant do you have?'
          input = io.gets.strip
          case input
          when /\D+/
            console 'Please enter numeric value of 0 or more'
          else
            input = input.to_i
            dependant = input if input >= 0
          end
        end
        dependant
      end

      def console(out)
        STDOUT.puts out
      end
    end
  end
end
