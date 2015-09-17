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
set :logging, true

configure :production do
  set :logging, Logger::ERROR
end

DEFAULT_COLOR = 'DDDCBF'
DEFAULT_SIZE  = 100
DEFAULT_BADGE_SIZE = 25
MAX_AGE = 15 * 60

use Rack::Cache

def tileService
  @_tileService ||= TileService.new
end
def badgeService
  @_badgeService ||= BadgeService.new
end

def color(color = nil)
  color = DEFAULT_COLOR if color.nil? || color.size == 0
  "##{color}"
end
  
get '/favicon.ico' do
end


def generate_tile(params)
  tileService.create(params[:base],
    color(params[:color]), 
    size: (params[:size] || DEFAULT_SIZE).to_i, 
    rotation: params[:r] || 0,
    hflip: params[:flip],
    vflip: params[:flop]
    )
end

def generate_badge(params)
  badgeService.create(params[:base], 
    size: (params[:size] || DEFAULT_BADGE_SIZE).to_i,
    friend: params[:f])
end

before do
  content_type :svg
end

get '/t/:base' do
  params[:size] = 200
  generate_tile(params).to_s
end
get '/t/:base/:size' do
  cache_control :public, max_age: MAX_AGE
  tile = generate_tile(params).to_s
  etag Digest::MD5.hexdigest(tile)
  tile
end
get '/t/:base/:size/:color' do
  cache_control :public, max_age: MAX_AGE
  tile = generate_tile(params).to_s
  etag Digest::MD5.hexdigest(tile)
  tile
end

get '/b/:base' do
  params[:size] = 200
  generate_badge(params).to_s
end
get '/b/:base/:size' do
  cache_control :public, max_age: MAX_AGE
  tile = generate_badge(params).to_s
  etag Digest::MD5.hexdigest(tile)
  tile
end

get '/' do
  content_type :text
  'hello'
end