source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'bootstrap-sass', '2.1'

# Gem Postgres in order to work with heroku
# We will be using postgres in development testing and deployment
gem 'pg'

# gems used only in development and testing
group :development, :test do
	gem 'rspec-rails', '2.11.0'
	gem 'guard-rspec'
	gem 'guard-spork'
	gem 'childprocess'
	gem 'spork'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails', '2.0.2'

group :test do
	gem 'capybara', '1.1.2'
end
