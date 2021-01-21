source 'http://rubygems.org'
ruby '3.0.0'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'puma'
gem 'rails', '~> 6.1.1'
gem 'sprockets-rails'

group :development, :test do
  gem 'bullet'
  gem 'tzinfo-data'
  gem 'rspec-rails'
  gem 'factory_bot'
  gem 'dotenv-rails'
end

gem 'haml-rails'
gem 'mainsms_api'
gem 'meta-tags'
gem 'aws-sdk-s3'
gem 'paperclip'
gem 'pg'
gem 'popper_js'
gem 'rack-canonical-host'
gem 'russian'
gem 'sitemap_generator'
gem 'sorcery'
gem 'unicode'
gem "roo", "~> 2.7.0"
gem 'rubyzip', require: false
gem 'active_link_to'
gem 'friendly_id'
gem 'gretel'
gem 'webpacker', git: 'https://github.com/rails/webpacker.git'
gem 'will_paginate'
gem 'delayed_job_active_record'
gem 'image_processing'
gem 'mailgun-ruby'
gem 'recaptcha'
gem 'shrine'
gem 'turbo-rails'

group :production do
  gem 'heroku-deflater'
  gem 'image_optim_bin'
  gem 'rack-cors', require: 'rack/cors'
  gem 'rails_12factor'
  gem 'dalli'
  gem 'memcachier'
end

