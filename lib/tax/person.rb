# frozen_string_literal: true

module Tax
  class Person
    attr_reader :monthly_income, :marital_status, :dependant

    def initialize
      @monthly_income = 0
      # Possible extraction
      @marital_status = nil
      @dependant = 0
    end

    def monthly_income=(value)
      if value.to_s.match?(/\D/)
        raise InvalidMonthlyIncomeValue,
              "Monthly Income should be a numeric value. Given value is : #{value}"
      end

      value = value.to_i
      if value.negative?
        raise InvalidMonthlyIncomeValue,
              "Monthly Income should be a positive number. Given value is : #{value}"
      end

      @monthly_income = value
    end

    def total_income
      monthly_income * 12
    end

    def marital_status=(status)
      status = status.downcase.to_sym
      case status
      when :single, :married
        @marital_status = status
      else
        raise Tax::InvalidMaritalValue, "Invalid marital value,  #{status}"
      end
    end

    def dependant=(num)
      if num.to_s.match?(/\D/)
        raise InvalidDependantValue,
              "Number of dependant should be a numeric value. Given value is : #{num}"
      end

      num = num.to_i
      if num.negative?
        raise InvalidDependantValue,
              "Number of dependant should be a positive number. Given value is : #{num}"
      end

      @dependant = num.to_i
    end

    def married?
      marital_status == :married
    end

    def single?
      marital_status == :single
    end
  end
end
