source 'http://rubygems.org'
ruby '2.6.5'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'bcrypt', git: 'https://github.com/codahale/bcrypt-ruby.git', :require => 'bcrypt'
gem 'jbuilder', '~> 2.5'
gem 'puma', '~> 3.12'
gem 'rails', '~> 6.0.2.1'
gem 'sprockets-rails'


group :development, :test do
  gem 'bullet'
  gem 'dotenv-rails'
  gem 'image_optim_pack'
  gem 'web-console'
  gem 'active_record_query_trace'
  gem 'sys-proctable'
  gem 'tzinfo-data'
  gem 'rspec-rails'
  gem 'factory_bot'
end


gem 'haml-rails'
gem 'mainsms_api'
gem 'meta-tags'
gem 'paperclip'
gem 'paperclip-compression'
gem 'paperclip-optimizer'
gem 'pg'
gem 'popper_js'
gem 'rack-canonical-host'
gem 'russian'
gem 'sitemap_generator'
gem 'sorcery'
gem 'unicode'
gem "roo", "~> 2.7.0"
gem 'rubyzip', require: false
gem 'aws-sdk-s3', require: false
gem 'active_link_to'
gem 'friendly_id'
gem 'gretel'
gem 'webpacker', '~> 4.x'
gem 'will_paginate'
gem 'delayed_job_active_record'
gem 'image_processing'
gem 'dotenv-rails'
gem 'mailgun-ruby', '~>1.1.6'
gem "recaptcha"

group :production do
  gem 'fog-aws', require: false
  gem 'heroku-deflater'
  gem 'image_optim_bin'
  gem 'rack-cors', require: 'rack/cors'
  gem 'rails_12factor'
  gem 'dalli'
  gem 'memcachier'
end

