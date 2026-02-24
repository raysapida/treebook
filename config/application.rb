require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SocialMedia
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Must be set in application.rb per the Rails upgrade guide.
    config.active_support.cache_format_version = 7.1

    # Kept from new_framework_defaults.rb (Rails 5.0 era) — not yet adopted.
    # Enabling forgery_protection_origin_check breaks controller tests that don't set an Origin header.
    config.action_controller.forgery_protection_origin_check = false
    # Enabling belongs_to_required_by_default would require auditing all models/factories first.
    config.active_record.belongs_to_required_by_default = false

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
