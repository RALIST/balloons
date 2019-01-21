class Admin::PricesController < Admin::AdminController
  def new
    @price = Price.new
  end

  def create
    @price = Price.create(price_params)
    if @price.save
      @price.upload_price
      redirect_to admin_root_path
    else
      render 'new'
    end
  end

  def parse_price
    Price.parse_price
    redirect_back(fallback_location: root_path)
  end

  private

  def price_params
    params.require(:price).permit(:price_sheet, :vendor, :type)
  end
end
