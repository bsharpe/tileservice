$:.unshift(File.expand_path('../lib', __FILE__))

require 'active_support/all'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/config_file'
require 'tile_service'
require 'badge_service'

set :public_folder, File.dirname(__FILE__) + '/public'
set :root, File.dirname(__FILE__)

configure :production do
  set :logging, Logger::ERROR
end

configure :development do 
  set :logging, Logger::DEBUG
end

DEFAULT_COLOR = 'DDDCBF'
DEFAULT_SIZE  = 200
DEFAULT_BADGE_SIZE = 100
MAX_AGE = 15 * 60

use Rack::Cache

before do
  content_type :svg
end

def color(color = nil)
  color = DEFAULT_COLOR if color.nil? || color.size == 0
  "##{color}"
end

def generate_tile(params)
  TileService.instance.create(params[:base],
    color(params[:c]), 
    size: (params[:s] || DEFAULT_SIZE).to_i, 
    rotation: params[:r] || 0,
    hflip: params[:flip],
    vflip: params[:flop]
    )
end

def generate_badge(params)
  BadgeService.instance.create(params[:base], 
    size: (params[:size] || DEFAULT_BADGE_SIZE).to_i,
    friend: params[:f])
end

####
# FAVICON
#
get '/favicon.ico' do
  content_type 'image/svg+xml'
  BadgeService.instance.create('traitor',size: 64,friend: true).to_s
end
get '/favicon.svg' do
  content_type 'image/svg+xml'
  BadgeService.instance.create('traitor',size: 64,friend: true).to_s
end

####
# TILES
#
get '/t/:base.svg' do
  generate_tile(params).to_s
end
get '/t/c/:base.svg' do
  cache_control :public, max_age: MAX_AGE
  tile = generate_tile(params).to_s
  etag Digest::MD5.hexdigest(tile)
  tile
end

####
# BADGES
#
get '/b/:base.svg' do
  generate_badge(params).to_s
end
get '/b/c/:base.svg' do
  cache_control :public, max_age: MAX_AGE
  tile = generate_badge(params).to_s
  etag Digest::MD5.hexdigest(tile)
  tile
end

####
# ROOT
#
get '/' do
  content_type :text
  'TileServer 0.2'
end