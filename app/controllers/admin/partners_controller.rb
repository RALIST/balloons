class Admin::PartnersController < Admin::AdminController

  before_action :set_partner,only: [:show, :edit, :destroy, :update]

  def new
    @partner = Partner.new
  end

  def index
    @partners = Partner.all
  end

  def show
  end

  def create
    @partner = Partner.create(business_params)
    if @partner.save
      redirect_to [:admin, @partner]
    end
  end

  def update
    if @partner.update(business_params)
      redirect_to [:admin, @partner]
    end
  end

  def destroy
    if @partner.destroy
      redirect_to admin_partners_path
    end
  end

  private
  def business_params
    params.require(:partner).permit(:name, :logo, images_attributes: [:id, :img, :style])
  end

  def set_partner
    @partner = Partner.find(params[:id])
  end

end
