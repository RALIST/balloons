class Admin::MainController < Admin::AdminController
  def index; end

  def download_price
    @city = 'izhevsk'
    @compositions = Composition.availible.all
    render xlsx: 'download_price', filename: 'price'
  end
end
