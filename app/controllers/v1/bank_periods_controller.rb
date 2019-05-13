class V1::BankPeriodsController < BaseController
  before_action :get_bank
  before_action :get_bank_period, only: [:show, :update, :destroy]

  # GET /banks/:bank_id/bank_periods
  def index
    json_response(@bank.bank_periods)
  end

  # GET /banks/:bank_id/bank_periods/:id
  def show
    json_response(@bank_period)
  end

  # POST /banks/:bank_id/bank_periods
  def create
    @bank.bank_periods.create!(bank_period_params)
    json_response(@bank, :created)
  end

  # PUT /banks/:bank_id/bank_periods/:id
  def update
    @bank_period.update(bank_period_params)
    head :no_content
  end

  # DELETE /banks/:bank_id/bank_periods/:id
  def destroy
    @bank_period.destroy
    head :no_content
  end

  private

  def get_bank
    @bank = Bank.find(params[:bank_id])
  end

  def get_bank_period
    @bank_period = @bank.bank_periods.find_by!(id: params[:id]) if @bank
  end

  def bank_period_params
    params.permit(:bank_id, :percentage, :days, :active)
  end

end
