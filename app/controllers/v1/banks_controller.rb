class V1::BanksController < BaseController
  before_action :get_bank, only: [:show, :update, :destroy]

  # GET /banks
  def index
    @banks = Bank.all
    json_response(@banks)
  end

  # POST /banks
  def create
    @bank = Bank.create!(bank_params)
    json_response(@bank, :created)
  end

  # GET /banks/:id
  def show
    json_response(@bank)
  end

  # PUT /banks/:id
  def update
    @bank.update(bank_params)
    head :no_content
  end

  # DELETE /banks/:id
  def destroy
    @bank.destroy
    head :no_content
  end

  private

  def get_bank
    @bank = Bank.find(params[:id])
  end

  def bank_params
    params.permit(:name)
  end
end
