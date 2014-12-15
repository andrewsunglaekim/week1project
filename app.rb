require 'sinatra'
require 'sinatra/activerecord'

require_relative './models/user'
require_relative './models/vendor'
require_relative './models/item'
require_relative './models/purchase'
require_relative './models/deal'
require 'pry'
require_relative './config/environments'




# binding.pry

get '/' do
	
	erb :index
end