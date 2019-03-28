class PaymentsController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  rescue_from ActiveRecord::NotNullViolation do |exception|
    render json: 'not_null_violation', status: :unprocessable_entity
  end

  def index
    render json: Payment.where(loan_id: params[:loan_id])
  end

  def show
    @payment = Payment.find_by(id: params[:id], loan_id: params[:loan_id])
    if @payment
      render json: Payment.find_by(id: params[:id], loan_id: params[:loan_id])
    else
      render json: 'not_found', status: :not_found
    end
  end

  def create
    if params[:loan_id] && params[:amount]
      @payment = Payment.create(payment_params)
      if @payment.valid?
        render json: @payment
      else
        render json: @payment.errors, status: :unprocessable_entity
      end
    else
      render json: 'missing_parameters', status: :unprocessable_entity
    end
  end

  private

  def payment_params
    params.permit(:loan_id, :amount)
  end
end
