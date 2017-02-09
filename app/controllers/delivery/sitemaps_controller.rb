class Delivery::SitemapsController < Delivery::DeliveryController
  layout nil
  def show
    redirect_to "https://s3.amazonaws.com/flashcards123/sitemaps/sitemap.xml.gz"
  end
end
