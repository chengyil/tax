require_relative 'spec_helper.rb'
RSpec.describe Tax::IDR do
  it 'accept numeric value' do
    value = Tax::IDR.new(1000000)
    expect(value).to eql(Tax::IDR.new(1000000))
  end
  it 'accept string value' do
    value = Tax::IDR.new('1.000.000')
    expect(value).to eql(Tax::IDR.new(1000000))
  end
  context 'should be numeric behavior' do
    it 'able to add' do
      value = Tax::IDR.new(1000000)
      expect(value + 1000000).to eql(Tax::IDR.new(2000000))
    end

    it 'numeric can add to idr' do
      value = Tax::IDR.new(1000000)
      expect(1000000 + value).to eql(Tax::IDR.new(2000000))
    end

    it 'able to substract' do
      value = Tax::IDR.new(1000000)
      expect(value - 500000).to eql(Tax::IDR.new(500000))
    end

    it 'numeric can substract from idr' do
      value = Tax::IDR.new(500000)
      expect(1000000 - value).to eql(Tax::IDR.new(500000))
    end

    it 'able to be divided' do
      value = Tax::IDR.new(1000000)
      expect(value / 2).to eql(Tax::IDR.new(500000))
    end

    it 'able to be multiplied' do
      value = Tax::IDR.new(1000000)
      expect(value * 2).to eql(Tax::IDR.new(2000000))
    end
  end
end
