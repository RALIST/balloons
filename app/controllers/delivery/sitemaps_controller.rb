class Delivery::SitemapsController < Delivery::DeliveryController
  layout nil
  def show
    data = open('https://s3-us-west-2.amazonaws.com/flashcards123/sitemaps/sitemap.xml')
    send_data data.read, type: 'application/xml', disposition: 'inline'
  end
end
