class Shop::ShopController < ApplicationController
  layout 'shop'
  # before_action :current_cart

  private

  def current_cart
    @cart = if current_user
              current_user.cart
            else
              Cart.find(session[:cart_id])
            end
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
    @cart
  end
end
