require 'sinatra'
require 'sinatra/activerecord'
require 'bcrpyt'
require 'pry'

require_relative './models/user'
require_relative './models/vendor'
require_relative './models/item'
require_relative './models/purchase'
require_relative './models/deal'
require_relative './config/environments'





# binding.pry

get '/' do
	@items = Item.all
	
	erb :index
end

get '/signup' do

	erb :signup
end

post '/signup' do

end

get '/create_item' do

	erb :create_item
end

post '/create_item' do
	@item = Item.create(name: params[:name], description: params[:description])
end

get '/create_vendor' do

	erb :create_vendor
end


