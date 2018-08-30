source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'active_model_serializers', '~> 0.10.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'devise_token_auth', '~> 0.1', github: 'denispasin/devise_token_auth'
gem 'rails', '~> 5.2.0'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '~> 1.3.0', require: false
gem "pundit"
gem 'sidekiq'
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'
group :production do
  gem "lograge"
  gem "logstash-event"
  gem 'logstash-logger'
  gem 'sentry-raven', '~> 1.2', '>= 1.2.2'
  gem "skylight"
end

group :development, :test do
  gem 'database_cleaner'
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 3.7'
  gem 'rspec_junit_formatter'
  gem 'rubocop', require: false
  gem 'simplecov', require: false, group: :test
end

group :development do
  gem 'annotate', require: false
  gem 'guard', require: false
  gem 'guard-annotate', require: false
  gem 'guard-rspec', require: false
  gem 'guard-rubocop', require: false
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'faker'
  gem 'shoulda-matchers', '~> 3.0'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

ruby File.read('./.ruby-version')
