module Tax
  class Console
    class IndividualTax
      attr_reader :io

      def initialize(io)
        @io = io
      end

      def run
        get_monthly_income
        get_relief
        # monthy_income by 12 : this might not always be 12
        # We could also need to include bonus?
        # Technically we don't really need annual
        @total_income = monthly_income * 12 
        @assessable_income = total_income - relief > 0 ? total_income - relief : 0
        taxpayable = get_taxpayable(assessable_income)
        console "Total income : #{total_income}"
        console "Assessable income : #{assessable_income}"
        console "Payable Tax : #{taxpayable}"
      end

      private
      attr_accessor :monthly_income, :relief, :total_income, :assessable_income

      # TODO
      # Possible to extract this out
      # But what is this name
      def get_monthly_income
        while monthly_income.nil?  
          console 'What is your monthly income?'
          input = io.gets.strip
          if input.match? /\D+/
            console 'Please enter numeric value'
          else
            @monthly_income = input.to_i 
          end
        end
      end

      # TODO
      # Possible to extract this out
      # Command interface for relief
      def get_relief
        while relief.nil?
          console 'Tax Relief : Declaration'
          console 'Marital Status:'
          console '1. Single'
          console '2. Married with no dependant'
          console '3. Married with 1 dependant'
          console '4. Married with 2 dependants'
          console '5. Married with 3 dependants'

          input = io.gets.strip
          @relief = case input
                    when '1'
                      54000000
                    when '2'
                      58500000
                    when '3'
                      63000000
                    when '4'
                      67000000
                    when '5'
                      72000000
                    end
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
