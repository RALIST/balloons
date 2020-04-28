class ItemsInComposition < ApplicationRecord
  belongs_to :item, optional: true
  belongs_to :composition
  belongs_to :product

  after_commit { UpdateCompositionsPriceJob.perform_later(product.id) }
end
