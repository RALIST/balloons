class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :new_call, :redirect_subdomain

  include MainHelper

  private
  def new_call
    @call = Call.new
  end

  def redirect_subdomain
    if request.host == 'www.bigairballoons.ru' || 'шариковаяфея.рф' || 'www.шариковаяфея.рф'
      redirect_to 'https://l2rate.com' + request.fullpath, :status => 301
    end
  end

end