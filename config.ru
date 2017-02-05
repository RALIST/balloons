# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

use Rack::CanonicalHost, 'bigairballoons.ru', ignore: ['shop.bigairballoons.ru']
run Rails.application
