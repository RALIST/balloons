require 'rack/cors'

if defined? Rack::Cors
  Rails.configuration.middleware.insert_before 0, Rack::Cors do
    allow do
      origins %w[
        https://bigairballoons.ru
        http://bigairballoons.ru
        https://www.bigairballoons.ru
        http://www.bigairballoons.ru
      ]
      resource '/assets/*',
               headers: :any,
               methods: :any,
               credentials: false
    end
  end
end
