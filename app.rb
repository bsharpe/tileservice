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

DEFAULT_COLOR = 'DDDCBF'
DEFAULT_SIZE  = 100

def tileService
  @_tileService ||= TileService.new
end

def color(color = nil)
  color = DEFAULT_COLOR if color.nil? || color.size == 0
  "##{color}"
end
  
get '/favicon.ico' do
end

get '/:base' do
  content_type :svg
  
  tileService.create(params[:base],
    color(), 
    size: DEFAULT_SIZE, 
    rotation: params[:r] || 0,
    hflip: params[:flip],
    vflip: params[:flop]
    ).to_s
end
get '/:base/:size' do
  content_type :svg  

  tileService.create(params[:base],
    color(), 
    size: params[:size].to_i, 
    rotation: params[:r] || 0,
    hflip: params[:flip],
    vflip: params[:flop]
    ).to_s
end
get '/:base/:size/:color' do
  content_type :svg

  tileService.create(params[:base],
    color(params[:color]), 
    size: params[:size].to_i, 
    rotation: params[:r] || 0,
    hflip: params[:flip],
    vflip: params[:flop]
    ).to_s
end

get '/' do
  content_type :text
  'hello'
end