source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby File.read(".ruby-version").chomp

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '7.0.8'
# Use postgresql as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
# gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# gem 'jquery-rails'

gem 'jsbundling-rails'

gem 'foreman'

gem 'foundation-rails', '~>6.4.1.2'

gem 'gon', '~> 6.4.0'

gem "devise", "~> 4.9.0"

gem 'acts-as-taggable-on', '~> 10.0.0'

gem 'figaro'

gem 'geocoder', '~> 1.8.1'

gem 'kaminari', '~> 1.2.2'

gem 'friendly_id', '~> 5.5.0'

gem 'google_drive', '~> 3.0.7'

gem 'archieml'

gem 'carrierwave-aws'

gem 'mini_magick', '~> 4.12.0'

# Form
gem 'simple_form', '~> 5.2.0'
gem 'simple_form_fancy_uploads', '0.5.0'

gem 'font-awesome-rails', '~> 4.7.0'

gem 'rest-client', '~> 2.1.0'

gem 'open_uri_redirections', '~> 0.2.1'

gem 'ranked-model', '~> 0.4.8'

gem 'gtm_rails'

gem 'meta-tags'

gem 'invisible_captcha', '~> 2.1.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
end

group :development do
  # Mail deliveries
  gem "letter_opener", '~> 1.8.1'

  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.8.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
