class Delivery::SitemapsController < Delivery::DeliveryController
  layout nil
  def show
    redirect_to "https://s3.amazonaws.com/#{ ENV['AWS_BUCKET'] }/sitemaps/sitemap.xml.gz"
  end
end
