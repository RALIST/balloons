class Admin::TexturesController < Admin::AdminController
  def new
    @texture = Texture.new
  end

  def show
    @items = texture.items.paginate(page: params[:page], per_page: 20)
  end

  def create
    @texture = Texture.create(texture_params)
    redirect_to admin_items_path
  end

  private

    def texture
      @texture ||= Texture.find(params[:id])
    end

  def texture_params
    params.require(:texture).permit(:name)
  end
end
