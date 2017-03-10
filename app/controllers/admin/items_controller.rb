class Admin::ItemsController < Admin::AdminController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def new
    @item = Item.new
    @product = @item.products.build
  end

  def create
    @item = Item.where(vendor_id: item_params[:vendor_id],
                        texture_id: item_params[:texture_id],
                        tone_id: item_params[:tone_id],
                        type_id: params[:type_id]).first_or_create! do |item|
      item.vendor_id = item_params[:vendor_id]
      item.tone_id = item_params[:tone_id]
      item.texture_id = item_params[:texture_id]
      item.type_id = item_params[:type_id]
      item.category_id = item_params[:category_id]
    end
    if @item.save
      @item.products.create!(item_params[:products_attributes][:"#{0}"])
      redirect_to admin_items_path
    end
  end

  def edit
  end

  def update
    @item.update(item_params)
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
  end

  def index
    case
    when params[:q]
      @items = Item.search(params[:q]).paginate(page: params[:page], per_page: 20)
    when params[:type]
      type = Type.find(params[:type])
      @items = Item.where(type: type).paginate(page: params[:page], per_page: 20)
    when params[:vendor]
      vendor = Vendor.find(params[:vendor])
      @items = Item.where(vendor: vendor).paginate(page: params[:page], per_page: 20)
    when params[:category]
      category = Category.find(params[:category])
      @items = Item.where(category: category).paginate(page: params[:page], per_page: 20)
    when params[:tone]
      tone = Tone.find(params[:tone])
      @items = Item.where(tone: tone).paginate(page: params[:page], per_page: 20)
    when params[:form]
      form = FoilForm.find(params[:form])
      @items = Item.where(foil_form: form).paginate(page: params[:page], per_page: 20)
    when params[:color]
      color = Color.find(params[:color])
      @items = Item.joins(:tone).where(tones: {color: color}).paginate(page: params[:page], per_page: 20)
    when params[:texture]
      texture = Texture.find(params[:texture])
      @items = Item.where(texture: texture).paginate(page: params[:page], per_page: 20)
    when params[:subcategory]
      subcategory = Subcategory.find(params[:subcategory])
      @items = subcategory.items.paginate(page: params[:page], per_page: 20)
    end
  end


  private
  def item_params
    params.require(:item).permit(:name, :desc, :type_id, :category_id,
      :vendor_id, :color_id, :texture_id, :tone_id,
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
end
