require 'rake'

namespace :clear_carts do
  task :clear_all  => :environment do
    puts "Найдено #{Cart.where(user_id: nil).count} пустых корзин"
    Cart.where(user_id: nil).destroy_all
  end
end
