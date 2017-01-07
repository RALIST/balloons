class User < ApplicationRecord
  authenticates_with_sorcery!

  has_one :cart
  has_many :orders, dependent: :destroy
end
