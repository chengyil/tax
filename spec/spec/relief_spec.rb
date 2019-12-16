require_relative 'spec_helper.rb'
RSpec.describe Tax::Relief do
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
  context 'should be able to gather all qualified relief' do
    it 'able to get qualified reliefs' do
      expect(Tax::Relief).to respond_to(:qualified_relief)
    end
    it 'able to get qualified reliefs' do
      expect(Tax::Relief.qualified_relief(tax_payer: tax_payer).size).to be 1
    end

    it 'able to get qualified reliefs amount' do
      reliefs = Tax::Relief.qualified_relief(tax_payer: tax_payer)
      reliefs.each do |relief|
        expect(relief).to respond_to(:amount)
      end
    end

    it 'able to get qualified reliefs amount' do
      reliefs = Tax::Relief.qualified_relief(tax_payer: tax_payer)
      dependant_relief = reliefs.find { |relief| Tax::Relief::Dependant === relief }
      expect(dependant_relief.amount.amount).to eql 63000000 
    end

  end
end
