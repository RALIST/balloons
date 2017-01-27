class Shop::ShopController < ApplicationController
  layout 'shop'
  before_action :current_cart


private
  def current_cart
    if current_user
      @cart = current_user.cart
    else
      @cart = Cart.find(session[:cart_id])
    end
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
    @cart
  end
end
