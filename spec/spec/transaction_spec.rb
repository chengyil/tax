require_relative 'spec_helper.rb'
RSpec.describe Tax::Transaction do
  it 'is either credit' do
    subject = nil
    expect{subject = described_class.new(type: Tax::Transaction::Credit)}.not_to raise_error
    expect(subject.credit?).to be true
  end

  it 'or debit' do
    subject = nil
    expect{subject = described_class.new(type: Tax::Transaction::Debit)}.not_to raise_error
    expect(subject.debit?).to be true
  end
end
