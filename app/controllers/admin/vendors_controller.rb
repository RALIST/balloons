class Admin::VendorsController < Admin::AdminController

  def new
    @vendor = Vendor.new
  end

  def create
    @vendor = Vendor.create(vendor_params)
    redirect_to admin_items_path
  end
  private
  def vendor_params
    params.require(:vendor).permit(:name, :country, :description, :logo)
  end
end
