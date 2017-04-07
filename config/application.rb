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
    config.action_mailer.smtp_settings = {
      address:              'smtp.mailgun.org',
      port:                 587,
      user_name:            ENV['MAIL_BOX'],
      password:             ENV['MAIL_PASSWORD'],
      authentication:       :plain,
      enable_starttls_auto: true}
    config.action_mailer.default_options = { from: 'orders@bigairballoons.ru' }

    config.time_zone = 'Samara'
    config.i18n.default_locale = :ru
    config.exceptions_app = self.routes
    Rack::Utils.multipart_part_limit = 512
    config.action_controller.asset_host = ENV['ASSET_HOST']
  end

end
