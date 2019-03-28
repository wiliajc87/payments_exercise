require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  describe '#index' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }

    it 'responds with a 200' do
      get :index, params: { loan_id: loan.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    let(:loan) { Loan.create!(id: 1, funded_amount: 100) }
    let(:payment) { Payment.create!(loan_id: loan.id, amount: 0) }

    it 'responds with a 200' do
      get :show, params: { loan_id: loan.id, id: payment.id }
      expect(response).to have_http_status(:ok)
    end

    context 'if the payment is not found' do
      it 'responds with a 404' do
        get :show, params: { loan_id: loan.id, id: 10000 }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#create' do
    let(:loan) { Loan.create!(id: 1, funded_amount: 100) }
    let(:valid_attributes) { { loan_id: loan.id, amount: 20 } }
    let(:missing_amount_attributes) { { loan_id: loan.id } }
    let(:exessive_amount_attributes) { { loan_id: loan.id, amount: 10000 } }

    it 'responds with a 200' do
      post :create, params: valid_attributes
      expect(response).to have_http_status(:ok)
      expect(Payment.first.amount).to eq(20)
      expect(Payment.first.loan_id).to eq(1)
    end

    context 'if the payment information is incomplete' do
      it 'responds with a 404' do
        post :create, params: missing_amount_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'if the payment amount is too high' do
      it 'responds with error' do
        post :create, params: exessive_amount_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
