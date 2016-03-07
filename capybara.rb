require 'capybara'
session = Capybara::Session.new(:selenium)
session.visit "http://localhost:3000"
