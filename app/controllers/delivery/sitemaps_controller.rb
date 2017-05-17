class Delivery::SitemapsController < Delivery::DeliveryController
  layout nil
  def show
    redirect_to "https://s3-us-west-2.amazonaws.com/flashcards123/sitemaps/sitemap.xml"
  end
end
