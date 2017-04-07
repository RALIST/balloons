class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :new_call

  def new_call
    @call = Call.new
  end
end
