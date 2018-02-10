class Delivery::DeliveryController < ApplicationController
  layout 'delivery'
  before_action :current_cart, :new_call, :tags, :receivers

  private

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
