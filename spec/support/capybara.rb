require "capybara/rails"
require 'capybara/rspec'

# Setup capybara webkit as the driver for javascript-enabled tests.
# Capybara.javascript_driver = :webkit

Capybara.default_selector = :css

Capybara.configure do |config|
  config.match = :prefer_exact
  config.ignore_hidden_elements = false
end

Capybara.register_driver :selenium_firefox do |app|
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end

# In our setup, for some reason the browsers capybara was driving were
# not openning the right host:port. Below, we force the correct
# host:port.
# Capybara.server_port = 7787

# We have more than one controller inheriting from
# ActionController::Base, and, in our app, ApplicationController redefines
# the default_url_options method, so we need to redefine the method for
# the two classes.
