class Loan < ActiveRecord::Base
  has_many :payments

  def outstanding_amount
    payments.count != 0 ? calculate_outstanding_amount(self) : funded_amount
  end

  def calculate_outstanding_amount(loan)
    payments_amount = loan.payments.collect {|pay| pay.amount}.sum
    return loan.funded_amount - payments_amount
  end
end
