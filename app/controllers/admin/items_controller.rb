class Admin::ItemsController < Admin::AdminController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to admin_items_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
  end

  def index
    @items = Item.all
  end

  private
  def item_params
    params.require(:item).permit(:name, :desc, :img, :price)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end