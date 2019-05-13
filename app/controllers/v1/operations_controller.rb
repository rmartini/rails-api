class V1::OperationsController < BaseController

  # GET /operations
  def index
    @operations = Operation.all
    json_response(@operations)
  end

  # POST /operations
  def create
    @operation = Operation.create!(operation_params)
    @operation_serialize = @operation.attributes
                                     .with_indifferent_access
                                     .merge(profit: @operation.profit,
                                            percentage: @operation.percentage)
    json_response(@operation_serialize, :created)
  end

  private

  def operation_params
    params.permit(:amount, :bank_period_id)
  end

end
