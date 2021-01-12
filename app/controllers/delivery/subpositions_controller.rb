class Delivery::SubpositionsController < Delivery::DeliveryController

  skip_before_action :verify_authenticity_token

  def up_quantity
    subposition.update_attribute(:quantity, subposition.quantity + 1)
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
    current_cart.total_with_discounts
  end

  def down_quantity
    if subposition.quantity > 1
      subposition.update_attribute(:quantity, subposition.quantity - 1)
      current_cart.total_with_discounts
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path) }
        format.js
      end
    else
      @subposition.destroy
      current_cart.total_with_discounts
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path) }
        format.js {render action: :destroy}
      end
    end
  end

  def add_subposition
    @position = Position.find(params[:position])
    if @position.sub_exists?(item)
      @position.add_quantity_to_sub(item, 1)
    else
      @position.subpositions.create(product: item, quantity: 1)
    end
    current_cart.total_with_discounts
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  def update
    subposition.update(sub_params) if params[:subposition][:quantity].to_i > 0
    respond_to do |format|
      format.html{ redirect_back(fallback_location: root_path) }
      format.js
    end
    current_cart.total_with_discounts
  end

  def destroy
    if subposition.destroy
      respond_to do |format|
        format.html
        format.js
      end
    end
    current_cart.total_with_discounts
  end

  private
    def subposition
      @subposition ||= Subposition.find(params[:id])
    end

    def sub_params
      params.require(:subposition).permit(:quantity)
    end
end
