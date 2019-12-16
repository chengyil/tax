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
        @relief = get_relief
        # monthy_income by 12 : this might not always be 12
        # We could also need to include bonus?
        # Technically we don't really need annual
        @total_income = tax_payer.total_income
        @assessable_income = total_income - relief > 0 ? total_income - relief : 0
        taxpayable = get_taxpayable(assessable_income)
        console "Total income : #{total_income}"
        console "Assessable income : #{assessable_income}"
        console "Payable Tax : %d" % taxpayable
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

      # TODO
      # Possible to extract this out
      # Command interface for relief
      def get_relief
        Tax::Relief.qualified_relief(tax_payer: tax_payer).reduce(0) do |amount, relief|
          amount += relief.amount
        end
      end

      def get_taxpayable(assessable_income)
        taxpayable = 0
        # TODO
        # Tax payable interface
        taxpayable += if assessable_income < 50000000
                        payable = assessable_income * 0.05
                        assessable_income = 0 
                        payable
                      else
                        assessable_income -= 50000000
                        50000000 * 0.05
                      end
        p taxpayable

        taxpayable += if assessable_income > 0 && assessable_income < 200000000 
                        payable = assessable_income * 0.15
                        assessable_income = 0 
                        payable
                      elsif assessable_income > 0 && assessable_income >= 200000000 
                        assessable_income -= 200000000
                        200000000 * 0.15
                      else
                        0
                      end

        taxpayable += if assessable_income > 0 && assessable_income < 250000000 
                        payable = assessable_income * 0.25
                        assessable_income = 0 
                        payable
                      elsif assessable_income > 0 && assessable_income >= 250000000 
                        assessable_income -= 250000000
                        250000000 * 0.25
                      else
                        0
                      end

        taxpayable += if assessable_income > 0
                        payable = assessable_income * 0.30
                        assessable_income = 0 
                        payable
                      else
                        0
                      end
        taxpayable
      end

      def console(out)
        STDOUT.puts out
      end
    end
  end
end
