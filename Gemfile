source "https://rubygems.org"

ruby "3.2.2"
gem "rails", "~> 7.1.0"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem 'rspec-rails', '~> 6.0.0'
  gem 'factory_bot_rails'
  gem "debug", platforms: %i[ mri windows ]
end

group :test do
  gem 'shoulda-matchers', '~> 5.0'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

end

