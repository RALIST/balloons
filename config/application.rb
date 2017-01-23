require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Balloons
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.serve_static_assets = true
    unless Rails.env.test?
      config.paperclip_defaults = {
        storage: :s3,
          s3_region: ENV['AWS_REGION'],
          s3_host_name: "s3-us-west-2.amazonaws.com",
          s3_credentials: {
            bucket: ENV['AWS_BUCKET'],
            access_key_id: ENV['AWS_ACCESS_KEY'],
            secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
          }
      }
    end

    config.time_zone = 'Samara'
  end
end
