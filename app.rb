$:.unshift(File.expand_path('../lib', __FILE__))

require 'active_support/all'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/config_file'
require 'tile_service'

set :public_folder, File.dirname(__FILE__) + '/public'
set :root, File.dirname(__FILE__)
set :logging, true

configure :production do
  set :logging, Logger::ERROR
end

DEFAULT_COLOR = 'fffefe'

def color(color = nil)
  color ||= DEFAULT_COLOR
  puts "##{color}"
  "##{color}"
end
  

get '/:base' do
  content_type :svg
  ts = TileService.new
  ts.create(params[:base],color).to_s
end
get '/:base/:color' do
  content_type :svg  
  ts = TileService.new
  ts.create(params[:base],color(params[:color])).to_s
end
get '/:base/:color/:size' do
  content_type :svg
  ts = TileService.new
  ts.create(params[:base],color(params[:color]), size: params[:size].to_i).to_s
end

get '/' do
  content_type :text
  'hello'
end