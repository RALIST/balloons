class Admin::ItemsController < Admin::AdminController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :collections, only: [:new, :create, :edit, :update]

  def new
    @item = Item.new
    @product = @item.products.build
  end

  def create
    @item = Item.where(vendor_id: item_params[:vendor_id],
                        texture_id: item_params[:texture_id],
                        tone_id: item_params[:tone_id]).first_or_create!
    @item.products.create!(item_params[:products_attributes][:"#{0}"])
    redirect_to admin_items_path
  end

  def edit
  end

  def update
    if @item.update!(item_params)
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
    @items_without_collection = Item.without_collection
    @items_without_img = Item.without_img
  end


  def destroy_items
    Item.destroy_without_compositions
  end

  private
  def item_params
    params.require(:item).permit(:name, :desc, :type_id, :category_id,
      :select_collection, :text_collection, :vendor_id,
      :color_id, :texture_id, :tone_id,
      products_attributes: [
        :size_id,
        :quantity,
        :price,
        :price_with_helium,
        :id,
        :barcode,
        :code,
        :quantity,
        :name])
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def collections
    @collections = Item.all.map{|i| i.collection}.reject(&:blank?).uniq
  end
end
