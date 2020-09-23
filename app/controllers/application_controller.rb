class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :new_call, :redirect_subdomain

  include MetaHelper

  private

  def new_call
    @call = Call.new
  end

  def redirect_subdomain
    if request.subdomain == 'www' || request.host == 'https://xn--80aafnmm2an5b6a3fc.xn--p1ai/' || request.host == 'xn--80aafnmm2an5b6a3fc.xn--p1ai/'
      redirect_to 'https://bigairballoons.ru' + request.fullpath, :status => 301
    end
  end

end
