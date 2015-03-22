source 'https://rubygems.org'
ruby "2.2.1"
# original gems
gem 'rails', '4.2.0'
gem 'sass-rails', '>= 5.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails', '~> 3.1.2'
gem 'turbolinks', '~> 2.4.0'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc

# Windows specific gem
#gem 'tzinfo-data', platforms: [:mingw, :mswin]

# gems added during the treehouse tutorials
gem 'bootstrap-sass', '~> 3.2.0.2'
gem 'devise', '~> 3.4.0'
gem 'simple_form', '>= 3.1.0.rc2'
gem 'state_machine', :git => 'https://github.com/seuros/state_machine.git'
gem 'draper', '~> 1.4.0'
gem 'js-routes', '~> 0.9.9'
gem 'paperclip', '>=3'
#added this for breadcrumbs helper instead of twitter-bootstrap-rails
gem 'bootstrap-sass-extras', '~> 0.0.2'
gem 'will_paginate', '~> 3.0'
gem 'bootstrap-will_paginate'

group :development do
  gem 'thin', '~> 1.6.3'
end

group :test do 
	gem 'shoulda', '~> 3.5.0'
	gem 'factory_girl_rails', '~> 4.5.0'
	gem 'sqlite3', '~> 1.3.9'
end

group :development, :test do
  gem 'log_buddy', '~> 0.7.0'
	gem 'hirb', '~> 0.7.2'
	gem 'pry-rails', '~> 0.3.2'
	gem 'pry-byebug', '~> 2.0.0'
end

#heroku required gems
gem 'pg', '~> 0.11'
gem 'unicorn', '~> 4.8.3'
group :production, :staging do
  gem 'rails_12factor', '~> 0.0.3'
end

# other gems added after the tutorials
gem 'high_voltage', '~> 2.2.1'
gem 'bloggy', '~> 0.3'
gem 'rack-attack', '~> 4.2.0'
gem 'kramdown', '~> 1.5.0'
