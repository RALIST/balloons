class Admin::ItemsController < Admin::AdminController
  before_action :set_item, only: %i[show edit update destroy]

  before_action :find_item, only: :create
  def new
    @item = Item.new
  end

  def create
    @product = @item.products.create(item_params[:products_attributes]["0"])
    if @product.save
      redirect_to admin_items_path
    else
      flash[:alert] = @product.errors.full_messages
      render 'new'

    end
  end

  def edit; end

  def update
    if @item.update(item_params)
      redirect_to admin_items_path
    end
  end

  def destroy
    @compositions = Composition.joins(:items).where(items: { id: @item.id })
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

  def show; end

  def index
    if params[:q]
      @items = Item.search(params[:q]).paginate(page: params[:page], per_page: 20)
    elsif params[:type]
      type = Type.find(params[:type])
      @items = Item.where(type: type).paginate(page: params[:page], per_page: 20)
    elsif params[:vendor]
      vendor = Vendor.find(params[:vendor])
      @items = Item.where(vendor: vendor).paginate(page: params[:page], per_page: 20)
    elsif params[:category]
      category = Category.find(params[:category])
      @items = Item.where(category: category).paginate(page: params[:page], per_page: 20)
    elsif params[:tone]
      tone = Tone.find(params[:tone])
      @items = Item.where(tone: tone).paginate(page: params[:page], per_page: 20)
    elsif params[:form]
      form = FoilForm.find(params[:form])
      @items = Item.where(foil_form: form).paginate(page: params[:page], per_page: 20)
    elsif params[:color]
      @items = Item.where(color_id: params[:color]).paginate(page: params[:page], per_page: 20)
    elsif params[:texture]
      texture = Texture.find(params[:texture])
      @items = Item.where(texture: texture).paginate(page: params[:page], per_page: 20)
    elsif params[:subcategory]
      subcategory = Subcategory.find(params[:subcategory])
      @items = subcategory.items.paginate(page: params[:page], per_page: 20)
    elsif params[:size]
      size = Size.find(params[:size])
      ids = []
      size.products.each do |product|
        ids << product.item.id
      end
      @items = Item.where(id: ids).paginate(page: params[:page], per_page: 20)
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :desc, :type_id, :category_id,
                                 :vendor_id, :color_id, :texture_id, :tone_id, :foil_form_id,
                                 products_attributes: %i[
                                   size_id
                                   quantity
                                   price
                                   price_with_helium
                                   id
                                   barcode
                                   code
                                   quantity
                                   name
                                   img
                                 ],
                                 subcategory_ids: [])
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def find_item
    @item = Item.find_or_create_by(texture_id: item_params[:texture_id],
                                   tone_id: item_params[:tone_id],
                                   foil_form_id: item_params[:foil_form_id],
                                   category_id: item_params[:category_id],
                                   type_id: item_params[:type_id],
                                   name: item_params[:name],
                                   color_id: item_params[:color_id])
  end
end
