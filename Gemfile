source 'https://rubygems.org'

ruby '3.2.2'

gem 'aasm'
gem 'bootsnap', require: false
gem 'bunny'
gem 'pg', '~> 1.1'
gem 'pry-rails'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.1.1'
gem 'tzinfo-data', platforms: %i[windows jruby]

group :test do
  gem 'shoulda-matchers', '~> 6.0'
end

group :development, :test do
  gem 'debug', platforms: %i[mri windows]
  gem 'factory_bot_rails'
  gem 'pry', '~> 0.14.2'
  gem 'pry-byebug', '~> 3.10'
  gem 'rspec-rails', '~> 7.0.0'
  gem 'rubocop'
  gem 'rubocop-rails', '~> 2.18'
  gem 'rubocop-rspec', '~> 2.19'
end
