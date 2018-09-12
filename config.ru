require 'rubygems'
require 'bundler'

Bundler.require

# map just one file
map "/favicon.ico" do
  nil
end

require File.expand_path '../app.rb', __FILE__
run Sinatra::Application
