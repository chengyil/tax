module Tax
  class Transaction
    Credit = :credit
    Debit = :debit

    attr_reader :type

    def initialize(type: nil)
      raise unless [Credit, Debit].include?(type)
      @type = type
    end

    def credit?
      type == Credit
    end

    def debit?
      type == Debit
    end
  end
end
