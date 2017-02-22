class Shop::ItemsController < Shop::ShopController

  def show
    @item = Item.find(params[:id])
  end
end
