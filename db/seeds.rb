loan1 = Loan.create!(funded_amount: 100.0)
loan2 = Loan.create!(funded_amount: 200.0)

Payment.create!(loan_id: loan1.id, amount: 20.0)
Payment.create!(loan_id: loan1.id, amount: 20.0)

Payment.create!(loan_id: loan2.id, amount: 40.0)
Payment.create!(loan_id: loan2.id, amount: 40.0)
