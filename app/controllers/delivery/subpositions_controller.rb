class Delivery::SubpositionsController < Delivery::DeliveryController

  def up_quantity
    @subposition = Subposition.find(params[:id])
    @subposition.update_attribute(:quantity, @subposition.quantity + 1)
    respond_to do |format|
      format.html{redirect_back(fallback_location: delivery_root_path)}
      format.js
    end
  end

  def down_quantity
    @subposition = Subposition.find(params[:id])
    if @subposition.quantity > 1
      @subposition.update_attribute(:quantity, @subposition.quantity - 1)
    else
      @subposition.destroy
    end
    respond_to do |format|
      format.html{redirect_back(fallback_location: delivery_root_path)}
      format.js
    end
  end

  def add_subposition
    item = Item.find(params[:item])
    @position = Position.find(params[:position])
    if @position.sub_exists?(item)
      @position.add_quantity_to_sub(item, params[:quantity])
    else
      @position.subpositions.create(item: item, quantity: 1)
    end
    respond_to do |format|
      format.html{ redirect_back(fallback_location: delivery_root_path) }
      format.js
    end
  end

  def update
    @subposition = Subposition.find(params[:id])
    if params[:subposition][:quantity].to_i > 0
      @subposition.update(sub_params)
    else
      @subposition.destroy
    end
    respond_to do |format|
      format.html
      format.js
    end
  end
  private
  def sub_params
    params.require(:subposition).permit(:quantity)
  end
end
