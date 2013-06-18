source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Gem Postgres in order to work with heroku
# We will be using postgres in development testing and deployment
gem 'pg'

# gems used only in development and testing
group :development, :test do
	gem 'rspec-rails'
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :test do
	gem 'capybara'
end
