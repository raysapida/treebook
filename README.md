[heroku demo](https://powerful-beach-8279.herokuapp.com/)

### What is this repository for? ###
* Started from Treehouse Ruby on Rails track on creating a facebook clone.
* This is my first Ruby on Rails app and I've used it to learn more about Rails in general.

### Features ###
* The design uses the bootstrap-sass gem
* User Authentication through the Ruby gem Devise
* Creating Friendships through the state_machine gem
* Status Updates 
* Picture and Album uploads through paperclip

### How do I get set up? ###
* Clone the repository and run `bundle install`
* To run locally, changed the settings in `database.yml` to connect a Postgresql database or change to sqlite3 in development. 
* Run `rake db:migrate`
* Run `rake tests` to make sure all tests pass
* All gems needed for deployment to Heroku are included but running `heroku run rake db:migrate` might fail; use`heroku pg:push <LOCAL DB> <HEROKU DB>` as a workaround if a Postgresql database can be set up locally.

#Using the Gems
### Jekyll/ Bloggy Gem ###
* Run `bundle exec rake np post-title` to create a new post in the `config/jekyll/_posts` directory
* Run `bundle exec rake generate` to generate the blog in the `public/blog` directory

### High Voltage ###
* Static pages can be added in the `app/views/pages/` directory

### Windows Specific ###
* Uncomment the gem for tzinfo-data
* There's a Windows specific issue with paperclip which can be found [here](https://github.com/thoughtbot/paperclip/issues/1429)


# Possible future improvements #
* Improve the About page and navigation
* Implementing a jekyll theme for the blog
* Implement the Rack Attack gem in `config/initializers/rack-attack.rb`
* Implement a front-end framework like Angular, Ember or Backbone to learn how it can interact with a rails app
* Implement a test suite with rspec
* Add OAuth authentication as an alternative to creating an account
* Test other gems and plugins that could be added. 
