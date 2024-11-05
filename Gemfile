source "https://rubygems.org"

ruby "3.1.0"
gem "rails", "~> 7.1.0"
gem "railsui", github: "getrailsui/railsui", branch: "main"
gem "sprockets-rails"
gem "sqlite3", "~> 1.4"
gem "puma", ">= 5.0"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"

gem "tzinfo-data", platforms: %i[ mswin mswin64 mingw x64_mingw jruby ]
gem "bootsnap", require: false

gem "image_processing", "~> 1.2"

group :development, :test do
  gem "debug", platforms: %i[ mri mswin mswin64 mingw x64_mingw ]
end

group :development do
  gem "web-console"
  gem "rack-mini-profiler"
  gem "error_highlight", ">= 0.4.0", platforms: [:ruby]
end

group :test do
  gem "rspec-rails"
  gem "capybara"
  gem "selenium-webdriver"
  gem "factory_bot_rails"
  gem "shoulda-matchers"
  gem "faker"
end
