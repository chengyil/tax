module Tax
  class Entry
    Credit = :credit
    Debit = :debit

    attr_reader :type, :amount, :description

    def initialize(type: '', amount: 0, description: '')
      @type = type 
      @amount = amount.to_idr
      @description = description 
    end
  end
end

require_relative 'entry/relief.rb'
require_relative 'entry/tax_payable.rb'
