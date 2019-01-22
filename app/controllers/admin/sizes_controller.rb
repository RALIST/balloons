class Admin::SizesController < Admin::AdminController

  before_action :set_size, only: [:show, :edit, :update, :destroy]

  def new
    @size = Size.new
  end

  def index
    @sizes = Size.all.order(:in_inch)
  end

  def show

  end

  def edit

  end

  def update

    if @size.update(size_params)
      redirect_to admin_sizes_path
      flash[:success] = 'Успешно!'
    end

  end

  def create
    @size = Size.create(size_params)
    redirect_to admin_items_path
  end

  def destroy
    if @size.destroy
      redirect_to admin_sizes_path
      flash[:success] = 'Удалено!'
    end
  end

  private

  def set_size
    @size = Size.find(params[:id])
  end

  def size_params
    params.require(:size).permit(:in_cm, :in_inch, :belbal, :value)
  end
end
