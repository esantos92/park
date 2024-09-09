source "https://rubygems.org"

ruby "3.2.2"

gem "rails", "~> 7.1.1"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

group :test do
  gem 'shoulda-matchers', '~> 6.0'
end

group :development do
  gem 'pry-rails'
end

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 7.0.0'
end

