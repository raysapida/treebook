source 'https://rubygems.org'
ruby "2.1.3"
# original gems
gem 'rails', '4.1.5'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc

# Windows specific gem
gem 'tzinfo-data', platforms: [:mingw, :mswin]

# gems added during the tutorials
gem 'bootstrap-sass'
gem 'devise'
gem 'simple_form', '>= 3.1.0.rc2'
gem 'state_machine', :git => 'https://github.com/seuros/state_machine.git'
gem 'draper'
gem 'js-routes'
gem "paperclip", ">=3"
#added this for breadcrumbs helper instead of twitter-bootstrap-rails
gem 'bootstrap-sass-extras' 
gem 'will_paginate', '~> 3.0'
gem 'bootstrap-will_paginate'
gem 'high_voltage', '~> 2.2.1'

group :development do
  gem 'thin'
end

group :test do 
	gem 'shoulda'
	gem 'factory_girl_rails'
end

group :development, :test do
	gem 'sqlite3'
  gem 'log_buddy'
end

group :production do
	gem "pg"
end

gem "foreman"
group :production, :staging do
  gem "rails_12factor"
  gem "rails_stdout_logging"
  gem "rails_serve_static_assets"
end

gem 'unicorn'
