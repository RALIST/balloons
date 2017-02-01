class Admin::PricesController < Admin::AdminController
  def new
    @price = Price.new
  end

  def create
    @price = Price.create(price_params)
    if @price.save
      redirect_to admin_root_path
    end
  end

  private
  def price_params
    params.require(:price).permit(:price_sheet)
  end
end
