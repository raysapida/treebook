source 'https://rubygems.org'

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

# gems added during the tutorial
gem 'bootstrap-sass'
gem 'devise'
gem 'simple_form', '>= 3.1.0.rc2'
gem 'state_machine', :git => 'https://github.com/seuros/state_machine.git'
gem 'draper'
gem 'js-routes'

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