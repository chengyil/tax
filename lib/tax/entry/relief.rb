module Tax
  class Entry
    class Relief < Entry
      def initialize(type: nil, amount: 0, description: nil)
        super(type: type, amount: amount, description: description)
      end
    end
  end
end
