class Admin::CompositionsController < Admin::AdminController
  before_action :set_comp, only: [:show, :edit, :update, :destroy]
  
  def index
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
  end

  def destroy
  end

  private

  def comp_params
    params.require(:composition).permit(:title, :img, :price)
  end

  def set_comp
    @comp = Composition.find(params[:id])
  end

end