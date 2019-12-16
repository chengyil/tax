module Tax
  class IDR
    include Comparable

    attr_reader :value

    def initialize(value)
      case value
      when Numeric
        @value = value.ceil
      when String
        @value = value.gsub('.','').to_i
      else
        raise Tax::IDRError, 'Only Numeric and String value can be IDR'
      end
    end

    def +(value)
      case value
      when Numeric
        self.class.new(@value + value)
      when IDR
        self.class.new(@value + value.value)
      end
    end

    def -(value)
      case value
      when Numeric
        self.class.new(@value - value)
      when IDR
        self.class.new(@value - value.value)
      end
    end

    def /(value)
      case value
      when Numeric
        self.class.new(@value / value)
      else
        raise Tax::IDRError, 'IDR can only be divided with a numeric value'
      end
    end

    def *(value)
      case value
      when Numeric
        self.class.new(@value * value)
      else
        raise Tax::IDRError, 'IDR can only be multiplied with a numeric value'
      end
    end

    def <=>(other)
      case other
      when IDR
        @value <=> other.value
      when Numeric
        @value <=> other 
      end
    end

    def ==(other)
      case other
      when IDR
        @value == other.value
      when Numeric
        @value == other 
      end
    end

    def eql?(other)
      case other
      when IDR
        @value == other.value
      when Numeric
        @value == other 
      end
    end

    def hash
      @value.hash
    end

    def coerce(other)
      case other
      when Numeric
        return self.class.new(other), self
      end
    end

    def to_i
      @value.to_i
    end

    def to_s
      "%s IDR" % @value.to_s.gsub(/(\d)(?=(\d{3})+$)/,'\1.')
    end

    def inspect
      to_s
    end
  end
end
