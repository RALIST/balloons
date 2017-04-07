# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'
require 'rack/cors'

if ENV['CANONICAL_HOST']
  use Rack::CanonicalHost, ENV['CANONICAL_HOST'], ignore: ['shop.bigairballoons.ru']
end
use Rack::Cors do
  allow do
    origins '*'
    resource '*', :headers => :any, :methods => [:get, :post, :delete, :put, :patch, :options, :head]
  end
end
run Rails.application
