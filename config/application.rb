require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Balloons
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.action_view.form_with_generates_remote_forms = false
    config.autoload_paths << Rails.root.join('lib')
    config.action_mailer.delivery_method = :mailgun
    config.action_mailer.mailgun_settings = {
      api_key: ENV['MAILGUN_API_KEY'],
      domain: ENV['MAILGUN_DOMAIN'],
      # api_host: 'api.eu.mailgun.net'  # Uncomment this line for EU region domains
    }
  end
end
