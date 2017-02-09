class ShopSubdomain
  def self.matches?(request)
    request.subdomain.present? && request.subdomain == 'shop'
  end
end
