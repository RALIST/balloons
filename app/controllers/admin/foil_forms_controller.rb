class Admin::FoilFormsController < Admin::AdminController
  def new
    @form = FoilForm.new
  end

  def show
    @items = form.items.paginate(page: params[:page], per_page: 20)
  end

  def create
    @form = FoilForm.create(form_params)
    if @form.save
      redirect_to admin_items_path
    else
      render 'new'
    end
  end

  private

  def form
    @form ||= FoilForm.find(params[:id])
  end

  def form_params
    params.require(:foil_form).permit(:name)
  end
end
