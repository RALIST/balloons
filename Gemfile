source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.0'

gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.1'

# Backgrounding
gem 'redis', '~> 4.0'
gem 'sidekiq'

# Assets
gem 'sass-rails', '>= 6'
gem 'turbo-rails'
gem 'webpacker', git: 'https://github.com/rails/webpacker.git'

# HTML helpers
gem 'friendly_id'
gem 'gretel'
gem 'haml-rails'
gem 'meta-tags'
gem 'pagy'
gem 'recaptcha'
gem 'sitemap_generator'
gem 'babosa'

# Mails
gem 'mailgun-ruby'
gem 'mainsms_api'

# Images
gem 'aws-sdk-s3'
gem 'image_processing', '~> 1.2'
gem 'shrine'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot'
  gem 'rspec-rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'annotate'
end
