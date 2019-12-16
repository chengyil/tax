require_relative 'spec_helper.rb'
RSpec.describe Tax::Person do
  context 'A individual tax payer' do
    it "tax payer should have monthly income" do
      expect(subject).to respond_to :monthly_income
    end

    it "tax payer should have marital status" do
      expect(subject).to respond_to :marital_status
    end

    it "tax payer should have dependant" do
      expect(subject).to respond_to :dependant
    end
  end

  context 'income' do
    it 'can set monthly income' do
      expect { subject.monthly_income = 650000 }.not_to raise_error
      expect(subject.monthly_income).to be 650000
      expect(subject.total_income).to be 7800000
    end

    it 'default to 0' do
      expect(subject.monthly_income).to be 0
      expect(subject.total_income).to be 0
    end

    it 'can only accept positive numeric' do
      expect { subject.monthly_income = 'none' }.to raise_error Tax::InvalidMonthlyIncomeValue
    end
  end

  context 'marital status' do
    it 'can be single' do
      expect { subject.marital_status = 'single' }.not_to raise_error
      expect(subject.marital_status).to be :single
    end
    it 'can be married' do
      expect { subject.marital_status = 'married' }.not_to raise_error
      expect(subject.marital_status).to be :married
    end
    it 'can only be single or married' do
      expect { subject.marital_status = 'none' }.to raise_error Tax::InvalidMaritalValue
    end
  end

  context 'dependant' do
    it 'describe number of dependant' do
      expect { subject.dependant = 3 }.not_to raise_error
      expect(subject.dependant).to be 3
    end

    it 'raise error if not given a numeric value' do
      expect { subject.dependant = 'three' }.to raise_error Tax::InvalidDependantValue
    end

    it 'raise error if value is lesser than 0' do
      expect { subject.dependant = -1 }.to raise_error Tax::InvalidDependantValue
    end
  end
end
