class Admin::CompositionsController < Admin::AdminController
  before_action :set_comp, only: [:show, :edit, :update, :destroy, :add_item, :remove_tag]

  def index
    @compositions = Composition.all
  end

  def show
  end

  def new
    @comp = Composition.new
  end

  def create
    @comp = Composition.create(comp_params)
    if @comp.save
      redirect_to admin_compositions_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @comp.update(comp_params)
    redirect_back fallback_location: admin_root_path
  end

  def destroy
  end

  def add_item
    @item = Item.find(params[:item])
    params[:count].to_i.times do
      @comp.items.push(@item)
    end
    @comp.comp_price
    respond_to do |format|
      format.html { redirect_back(fallback_location: admin_root_path) }
      format.js
    end
  end

  def remove_tag
    @tag = Tag.find(params[:tag_id])
    @comp.tags.delete(@tag)
    redirect_back fallback_location: admin_root_path
  end

  private

  def comp_params
    params.require(:composition).permit(:title, :img, :price, :tag_name)
  end

  def set_comp
    @comp = Composition.find(params[:id])
  end

end
