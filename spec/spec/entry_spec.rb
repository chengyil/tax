require_relative 'spec_helper.rb'
RSpec.describe Tax::Entry do
  let(:type) { 'Dependant Relief' }
  let(:description) { 'Single' }
  let(:amount) { 1000 }

  subject { described_class.new(type: type, amount: amount, description: description) }

  it 'has type' do
    expect(subject.type).to be type 
  end

  it 'has amount' do
    expect(subject.amount).to eql amount
  end

  it 'has description' do
    expect(subject.description).to be description
  end
end
