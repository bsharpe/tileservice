$:.unshift(File.expand_path('../lib', __FILE__))

require 'active_support/all'
require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/config_file'
require 'tile_service'
require 'badge_service'
require 'dot_service'
require 'iodine'

set :public_folder, File.dirname(__FILE__) + '/public'
set :root, File.dirname(__FILE__)

configure :production do
  set :logging, Logger::ERROR
end

configure :development do
  set :logging, Logger::DEBUG
end

if (defined?(Iodine))
  Iodine.threads = ENV.fetch("RAILS_MAX_THREADS", 5).to_i if Iodine.threads.zero?
  Iodine.workers = ENV.fetch("WEB_CONCURRENCY", 2).to_i if Iodine.workers.zero?
  Iodine::DEFAULT_SETTINGS[:port] = ENV.fetch("PORT", 3000).to_i
end

DEFAULT_COLOR = 'DDDCBF'
DEFAULT_SIZE  = 200
DEFAULT_BADGE_SIZE = 100
MAX_AGE = 60 * 60

use Rack::Cache

before do
  content_type :svg
end

def color(color = nil)
  color = DEFAULT_COLOR if color.nil? || color.size == 0
  "##{color}"
end

def generate_dots(params)
  enemies,team,faction,friends = params[:count].split('_')
  DotService.instance.create(enemies.to_i,
    size: (params[:s] || DEFAULT_SIZE).to_i,
    team: team.to_i,
    faction: faction.to_i,
    friends: friends.to_i)
end

def generate_tile(params)
  if params[:r]
    if params[:r].match(/\d+/)
      r = params[:r].to_i
      if r < 6
        case r
        when 1..3
          params[:r] = r * 90
        when 4
          params[:r] = 0
          params[:flip] = true
        when 5
          params[:r] = 0
          params[:flop] = true
        end
      else
        params[:r] = ((r / 22.5).round * 22.5).round
      end
    else
      case params[:r]
      when 'flip'
        params[:flip] = true
      when 'flop'
        params[:flop] = true
      end
      params[:r] = 0
    end
  end
  TileService.instance.create(params[:base],
    color(params[:c]),
    size: (params[:s] || DEFAULT_SIZE).to_i,
    rotation: params[:r] || 0,
    hflip: params[:flip],
    vflip: params[:flop],
    owner_percent: params[:p],
    owner_color: params[:o],
    highlight: params[:h]
    )
end

def generate_badge(params)
  BadgeService.instance.create(params[:base],
    size: (params[:s] || DEFAULT_BADGE_SIZE).to_i,
    friend: params[:f],
    tile: params[:t],
    badge_size: params[:bs])
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
# DOTS
#
get '/d/:count.svg' do
  generate_dots(params).to_s
end
get '/d/c/:count.svg' do
  cache_control :public, max_age: MAX_AGE
  tile = generate_dots(params).to_s
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

####
# HONEYPOT
#
get '/phpmyadmin' do
  sleep(60)
end

post '/login.action' do
  sleep(60)
end