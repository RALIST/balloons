class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :new_call, :cors_set_access_control_headers

  def new_call
    @call = Call.new
  end

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
    headers['Access-Control-Max-Age'] = "1728000"
  end
end
