class Payment < ActiveRecord::Base
  belongs_to :loan
  validate :amount_cannot_exceed_outstanding_loan_amount

  private

  def amount_cannot_exceed_outstanding_loan_amount
    loan = Loan.find(loan_id)
    if loan.outstanding_amount < amount
      errors.add(:amount, 'must not exceed remaining amount on loan')
    end
  end
end
