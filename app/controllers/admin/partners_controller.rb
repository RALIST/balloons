class Admin::PartnersController < Admin::AdminController
  before_action :set_partner, only: %i[show edit destroy update]

  def new
    @partner = Partner.new
  end

  def index
    @partners = Partner.all
  end

  def show; end

  def create
    @partner = Partner.create(business_params)
    redirect_to [:admin, @partner] if @partner.save
  end

  def update
    redirect_to [:admin, @partner] if @partner.update(business_params)
  end

  def destroy
    redirect_to admin_partners_path if @partner.destroy
  end

  private

  def business_params
    params.require(:partner).permit(:name, :logo, images_attributes: %i[id img style])
  end

  def set_partner
    @partner = Partner.find(params[:id])
  end
end
