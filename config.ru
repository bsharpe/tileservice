require 'rubygems'
require 'bundler'

Bundler.require

require File.expand_path '../app.rb', __FILE__
run Sinatra::Application
