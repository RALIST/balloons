class Admin::FoilFormsController < Admin::AdminController
  def new
    @form = FoilForm.new
  end

  def create
    @form = FoilForm.create(form_params)
    if @form.save
      redirect_to admin_items_path
    else
      rendre 'new'
    end
  end

  private
  def form_params
    params.require(:foil_form).permit(:name)
  end
end
