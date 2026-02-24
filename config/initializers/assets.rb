# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )

# Sprockets 4 does not support Regexp entries in precompile. bootstrap-sass 3.x
# registers glyphicon fonts via a Regexp, which raises NoMethodError in Sprockets 4.
# Replace the Regexp with explicit String paths.
Rails.application.config.after_initialize do
  Rails.application.config.assets.precompile.delete_if { |p| p.is_a?(Regexp) }
  Rails.application.config.assets.precompile += %w[
    bootstrap/glyphicons-halflings-regular.eot
    bootstrap/glyphicons-halflings-regular.svg
    bootstrap/glyphicons-halflings-regular.ttf
    bootstrap/glyphicons-halflings-regular.woff
    bootstrap/glyphicons-halflings-regular.woff2
  ]
end
