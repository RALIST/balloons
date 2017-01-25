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
    if @item.update(item_params)
      redirect_to admin_item_path(@item)
    else
      render 'edit'
    end
  end

  def destroy
  end

  def show
    @item = Item.find(params[:id])
  end

  def index
    @companies = Item.all.map{|i| i.made_by}.uniq
    @types = Item.all.map{ |i| i.item_type }.uniq
    @collections = Item.all.map{|i| i.collection}.reject(&:blank?).uniq
    @items = Item.search(params[:query]).paginate(page: params[:page], per_page: 10) unless params[:query].blank?
  end

  private
  def item_params
    params.require(:item).permit(:name, :desc, :img, :price, :price_with_helium,
                                  :item_type, :collection)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
