class BaseController < ApplicationController
  JSON_API_REQUIRED_REQUEST_HEADER = "application/vnd.api+json"

  before_action :check_request_headers!

  def check_request_headers!
    return if request.headers[:accept] == JSON_API_REQUIRED_REQUEST_HEADER
    fail ActionController::BadRequest
  end

end
