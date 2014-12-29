require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rbshop
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Moscow'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ru
    
    mail_conf_path = 'config/mail.yml'
    mail_config = File.exists?(mail_conf_path) ? YAML::load_file(mail_conf_path).symbolize_keys : {}
    
    config.action_mailer.default_url_options = { host: 'rbdis.ru' }
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = mail_config
    
    # config.action_mailer.default_url_options = { host: "krasivopodano.ru" }
    # config.action_mailer.delivery_method = :smtp
    # 
    # config.action_mailer.smtp_settings = {
    #   address:        "smtp.locum.ru",
    #   port:           25, 
    #   domain:         "locum.ru",
    #   authentication: "login",
    #   user_name:      "iam@babrovka.ru",
    #   password:       "111715",
    #   enable_starttls_auto: false,
    #   openssl_verify_mode: false 
    # }

    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: true,
        request_specs: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end


end
end
