class Delivery::SitemapsController < Delivery::DeliveryController
  layout nil
  def show
    data = open('https://s3.eu-central-1.amazonaws.com/balloons-images/sitemaps/sitemap.xml')
    send_data data.read, type: 'application/xml', disposition: 'inline'
  end
end
