require 'rails_helper'

RSpec.describe Payment, type: :model do
  describe('validations') do
    let(:loan) { Loan.create!(id: 1, funded_amount: 100.0) }
    it 'won\t create a payment that exceedes the loan\'s outstanding amount' do
      payment = Payment.new(loan_id: loan.id, amount: 200)
      expect(payment).to_not be_valid
    end
  end
end
