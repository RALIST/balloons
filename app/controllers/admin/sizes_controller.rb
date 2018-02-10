class Admin::SizesController < Admin::AdminController
  def new
    @size = Size.new
  end

  def create
    @size = Size.create(size_params)
    redirect_to admin_items_path
  end

  private

  def size_params
    params.require(:size).permit(:in_cm, :in_inch, :belbal)
  end
end
