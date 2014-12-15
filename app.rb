require 'sinatra'
require 'sinatra/activerecord'
require 'bcrypt'
require 'pry'

require_relative './models/user'
require_relative './models/vendor'
require_relative './models/item'
require_relative './models/purchase'
require_relative './models/deal'
require_relative './config/environments'

enable :sessions

before do

	@errors ||= []
	# puts session[:user_id]
	@current_user = User.find(session[:user_id])
end

# binding.pry

get '/' do
	@items = Item.all
	@users = User.all
	
	erb :index
end

get '/signup' do

	erb :signup
end

post '/signup' do
	@password = BCrypt::Password.create(params[:password])
	if params[:password] == params[:password_confirm]
		user = User.new(name: params[:name], email: params[:email], username: params[:username], password_digest: @password)
		if user.save
			session[:user_id] = user.id
			redirect('/')
		else
			@errors << "Invalid email or password"
			erb :signup
		end
	else
		@errors << "Password does not match"
		erb :signup
	end
end

get '/login' do

	erb :login
end

post '/login' do
	@user = User.find_by(username: params[:username])
	if @user && @user.authenticate(params[:password])
		session[:user_id] = @user.id
		redirect '/'
	else
		@errors << "Invalid email or password. Please try again."
		erb :login
	end
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

post '/create_vendor' do

end


