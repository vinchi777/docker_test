Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Allow better errors to access vagrant
  # Install plugin first -> vagrant plugin install vagrant-host-path
  if defined? BetterErrors
    # Opening files
    BetterErrors.editor = proc { |full_path, line|
      full_path = full_path.sub(Rails.root.to_s, ENV["VAGRANT_HOST_PATH"])
      "subl://open?url=file://#{full_path}&line=#{line}"
    }

    # Allowing host
    host = ENV["SSH_CLIENT"] ? ENV["SSH_CLIENT"].match(/\A([^\s]*)/)[1] : nil
    BetterErrors::Middleware.allow_ip! host if [:development, :test].member?(Rails.env.to_sym) && host
  end
end
