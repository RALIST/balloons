class Delivery::DeliveryController < ApplicationController
  layout 'delivery'
  before_action :current_cart, :new_call, :tags, :receivers


private
  def current_cart
    if current_user
      unless current_user.cart.blank?
        @cart = current_user.cart
      else
        @cart = Cart.create
        session[:cart_id] = @cart.id
        current_user.cart = @cart
      end
    else
      @cart = Cart.find(session[:cart_id])
    end
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
    @cart
  end

  def new_call
    @call = Call.new
  end

  def tags
    @menu_tags = Tag.composition_tags.map(&:name).uniq
  end

  def receivers
    @menu_receivers = Receiver.all.map(&:title).uniq
  end
end
