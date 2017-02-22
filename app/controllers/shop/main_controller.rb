class Shop::MainController < Shop::ShopController

  def index
    @items = Item.all.includes(:products, :sizes, :texture, :tone, :vendor).paginate(page: params[:page], per_page: 20)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def search
  end
end
