class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :new_call, :redirect_subdomain

  include MainHelper

  private
  def new_call
    @call = Call.new
  end

  def redirect_subdomain
    if request.subdomain == 'www' || request.host == 'шариковаяфея.рф' || request.host == 'www.шариковаяфея.рф'
      redirect_to 'https://bigairballoons.ru' + request.fullpath, :status => 301
    end
  end

end