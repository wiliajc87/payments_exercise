require 'rails_helper'

RSpec.describe Loan, type: :model do
  describe '#outstanding_amount' do
    let(:unpaid_loan) { Loan.create!(id: 1, funded_amount: 100.0) }
    let(:paid_loan) { Loan.create!(id: 2, funded_amount: 100.0) }

    it 'returns funded_amount when no payments exist' do
      expect(unpaid_loan.outstanding_amount).to eq(100)
    end

    it 'returns funded_amount when payments exist' do
      Payment.create!(id: 1, loan_id: paid_loan.id, amount: 20.0)
      Payment.create!(id: 2, loan_id: paid_loan.id, amount: 30.0)
      expect(paid_loan.outstanding_amount.to_f).to eq(50.0)
    end
  end
end
