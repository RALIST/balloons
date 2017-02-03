class Admin::ItemsController < Admin::AdminController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :collections, only: [:new, :create, :edit, :update]

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
    @compositions = Composition.joins(:items).where(items:{id: @item.id})
    if @compositions.any?
      flash[:danger] = "Товар используется в композициях #{@compositions.map(&:id).uniq}"
      redirect_to admin_items_path
    else
      if @item.destroy
        flash[:success] = 'Товар удален!'
        redirect_back fallback_location: admin_root_path
      end
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def index
    @companies = Item.all.map{|i| i.made_by}.reject(&:blank?).uniq
    @types = Item.all.map{ |i| i.item_type }.uniq
    @collections = Item.all.map{|i| i.collection}.reject(&:blank?).uniq
    unless params[:query].blank?
      @items = Item.search(params[:query]).order(:name)
    else
      @items = Item.all.order(:name).order(:name)
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :desc, :img, :price, :price_with_helium,
                                  :item_type, :collection, :color,
                                  :size, :quantity, :availible_in_comps, :barcode,
                                  :made_by, :min_order, :quantity_type,
                                  :select_collection, :text_collection)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def collections
    @collections = Item.all.map{|i| i.collection}.reject(&:blank?).uniq
  end
end
