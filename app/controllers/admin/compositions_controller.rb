class Admin::CompositionsController < Admin::AdminController
  before_action :set_comp, only: %i[show edit update destroy
                                    add_item remove_tag remove_receiver
                                    update_price delete remove_item]

  def index
    @compositions = Composition.availible
    @compositions_without_items = Composition.without_items.order(:id)
    @compositions_without_tags = Composition.without_tags.order(:id)
  end

  def show
    @products = @comp.products.uniq
    if params[:q]
      @items = Product.search(params[:q].downcase).paginate(page: params[:page], per_page: 50)
    end
  end

  def new
    @comp = Composition.new
  end

  def create
    if params[:imgs]
      params[:imgs].each do |img|
        @comp = Composition.create(img: img)
      end
    else
      @comp = Composition.create(comp_params)
      if @comp.save
        redirect_to admin_compositions_path
      else
        render 'new'
      end
    end
  end

  def edit; end

  def update
    @comp.update(comp_params)
    redirect_back fallback_location: admin_root_path
  end

  def destroy
    if @comp.destroy
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def add_item
    @products = @comp.products.uniq
    @product = Product.find(params[:item])
    params[:count].to_i.times do
      @comp.products.push(@product)
    end
    @comp.update_price
    respond_to do |format|
      format.html { redirect_to admin_composition_path(@comp) }
      format.js
    end
  end

  def remove_tag
    @tag = Tag.find(params[:tag_id])
    @comp.tags.delete(@tag)
    redirect_back fallback_location: admin_root_path
  end

  def remove_receiver
    @receiver = Receiver.find(params[:receiver_id])
    @comp.receivers.delete(@receiver)
    redirect_back fallback_location: admin_root_path
  end

  def update_price
    @comp.update_price
    redirect_back fallback_location: admin_root_path
  end

  def remove_item
    @product = Product.find(params[:product_id])
    @comp.products.delete(@product)
    @comp.comp_price
    redirect_back fallback_location: admin_root_path
  end

  private

  def comp_params
    params.require(:composition).permit(:title, :img, :price, :tag_name, :deleted, :receiver_title)
  end

  def set_comp
    @comp = Composition.find(params[:id])
  end
end
