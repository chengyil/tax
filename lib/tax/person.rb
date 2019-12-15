module Tax
  class Person
    attr_accessor :monthly_income, :marital_status, :dependant
    
    def initialize
      @monthly_income = 0
      # Possible extraction
      @marital_status = nil
      @dependant = 0
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
      raise InvalidDependantValue, "Number of dependant should be a numeric value. Given value is : #{num}" if num.to_s.match? /\D/
      num = num.to_i
      raise InvalidDependantValue, "Number of dependant should be a positive number. Given value is : #{num}num}" unless num.to_s.match? /\D/ if num < 0
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
