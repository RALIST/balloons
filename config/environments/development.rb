Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.
  config.action_dispatch.tld_length = 0
  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => 'public, max-age=172800'
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = false

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  # config.file_watcher = ActiveSupport::EventedFileUpdateChecker
  # Paperclip.options[:command_path] = 'C:/Program Files/ImageMagick-7.0.4-Q16'
  config.action_mailer.default_url_options = {
    :host => 'localhost:3000',
    :only_path => false
  }
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.asset_host = 'http://localhost:3000'
  config.action_mailer.default_options = { from: 'danilov@ralist.ru' }
  config.action_mailer.perform_deliveries = true
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
  # unless Rails.env.test?
  #   config.paperclip_defaults = {
  #     default_url: 'https://s3.eu-central-1.amazonaws.com/images/missing/small/missing_small.png',
  #     storage: :s3,
  #       s3_region: ENV['AWS_REGION'],
  #       s3_host_name: "s3.eu-central-1.amazonaws.com",
  #       s3_protocol: :https,
  #       path: ':class/:attachment/:style/:filename',
  #       s3_headers: { 'Expires': 1.year.from_now.httpdate },
  #       s3_credentials: {
  #         bucket: ENV['AWS_BUCKET'],
  #         access_key_id: ENV['AWS_ACCESS_KEY'],
  #         secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
  #       }
  #   }
  # end
end
