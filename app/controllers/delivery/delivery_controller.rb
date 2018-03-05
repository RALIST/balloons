class Delivery::DeliveryController < ApplicationController
  layout 'delivery'
  include MetaHelper
  before_action :current_cart, :new_call, :tags, :receivers
  before_action :set_location
  before_action :set_meta_og





  private

  def set_location
    @city = city_from_params || user_location || default_city
  end

  def user_location
    @city = request.location.city.downcase
    if @city.blank? || !availible_cities.include?(@city)
      false
    end
  end

  def city_from_params
    if availible_cities.include?(params[:city])
      params[:city]
    else
      default_city
    end
  end

  def default_url_options
    if @city == default_city
      {city: nil}
    else
      {city: @city}
    end
  end

  def availible_cities
    cities = User::CITIES
  end


  def default_city
    'izhevsk'
  end

  def current_cart
    if current_user
      if current_user.cart.blank?
        @cart = Cart.create
        cookies.permanent[:cart_id] = @cart.id
        current_user.cart = @cart
      else
        @cart = current_user.cart
      end
    else
      @cart = Cart.find(cookies[:cart_id])
    end
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    cookies.permanent[:cart_id] = @cart.id
    @cart
  end

  def new_call
    @call = Call.new
  end

  def tags
    @menu_tags = Tag.composition_tags
  end

  def receivers
    @menu_receivers = Receiver.all.select('distinct on (title) *')
  end
end
