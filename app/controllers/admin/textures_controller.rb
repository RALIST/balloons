class Admin::TexturesController < Admin::AdminController

  def new
    @texture = Texture.new
  end

  def create
    @texture = Texture.create(texture_params)
    redirect_to admin_items_path
  end

  private
  def texture_params
    params.require(:texture).permit(:name)
  end
end
