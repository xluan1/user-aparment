# frozen_string_literal: true

module RestController
  require 'rack/utils'

  def rest_response(object, reference = nil, message = "Successful action", status = 200)
    render json: { data: object, message: message, status: status }, include: reference, status: status
  end

  def rest_error(message = "An error occurred", status = 500)
    rest_response Rack::Utils::HTTP_STATUS_CODES[status],nil,  message, status
  end
end
