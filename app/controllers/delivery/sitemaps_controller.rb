class Delivery::SitemapsController < Delivery::DeliveryController
  layout nil
  def show
    respond_to do |format|
      format.xml_gz { render file: 'public/sitemap.xml.gz'}
      format.html { redirect_to root_url }
    end
  end
end
