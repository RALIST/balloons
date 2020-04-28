class UpdateCompositionsPriceJob < ApplicationJob

  def perform(id)
    product = Product.find_by(id: id)
    return unless product.compositions.present?

    product.compositions.find_each{ |c| c.update_price! }
  end
end
