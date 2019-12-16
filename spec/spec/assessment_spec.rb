require_relative 'spec_helper.rb'
RSpec.describe Tax::Assessment::Individual do
  let (:monthly_income) { 650000 }
  let (:total_income) { 7800000 }
  let (:marital_status) { :married }
  let (:married) { true }
  let (:single) { false }
  let (:dependant) { 1 }
  let (:tax_payer) do
    tax_payer = instance_double("Tax::Person")
    allow(tax_payer).to receive(:monthly_income).and_return(monthly_income)
    allow(tax_payer).to receive(:total_income).and_return(total_income)
    allow(tax_payer).to receive(:marital_status).and_return(marital_status)
    allow(tax_payer).to receive(:married?).and_return(married)
    allow(tax_payer).to receive(:single?).and_return(single)
    allow(tax_payer).to receive(:dependant).and_return(dependant)
    tax_payer
  end
  it 'able to calculate tax payable' do
    described_class.new(tax_payer: tax_payer)
  end
end
