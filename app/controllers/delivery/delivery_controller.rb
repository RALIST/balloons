class Delivery::DeliveryController < ApplicationController
  layout 'delivery'

  before_action :current_cart, :new_call, :set_tags
  before_action :set_location
  before_action :set_meta_og

  etag { [current_user.try(:id), current_cart.try(:subpositions)] }


  def set_tags
    @tags = Tag.joins(:compositions).distinct
    @menu_receivers = Receiver.joins(:compositions).distinct
  end


  private

  def disable_sidebar
    @disable_sidebar = true
    @disable_help = true
  end

  def set_location
    @city = default_city
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
        @cart = current_user.cart.create!
        cookies.permanent[:cart_id] = @cart.id
        current_user.cart = @cart
      else
        @cart = current_user.cart
      end
    else
      @cart = Cart.find(cookies[:cart_id])
    end
    return @cart
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create!
    cookies.permanent[:cart_id] = @cart.id
    return @cart
  end

  def new_call
    @call = Call.new
  end
end
