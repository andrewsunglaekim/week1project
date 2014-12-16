require 'sinatra'
require 'sinatra/reloader'
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
	@current_user = User.find_by(id: session[:user_id])
end

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
			redirect("/users/#{user.username}")
		else
			@errors << "username or email already exists in system"
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
		redirect("/users/#{@user.username}")
	else
		@errors << "Invalid email or password. Please try again."
		erb :login
	end
end

get '/items' do
	@items = Item.all
	erb :items
end

get '/items/:id' do
	@item = Item.find(params[:id])
	@item.destroy
	redirect("/items")
end

get '/users/:username' do
	@vendors = @current_user.vendors.all.sort_by{|vendor|vendor.name.downcase}
	@items = Item.all.sort_by{|item|item.name.downcase}
	@deals = Deal.all
	puts @deals.inspect
	puts @items.inspect
	puts @vendors.inspect
	erb :users
end

get '/users/:username/vendors' do
	@vendors = @current_user.vendors
	erb :vendors
end

get '/users/:username/vendors/:id' do
	@vendor = Vendor.find(params[:id])
	@vendor.destroy
	redirect("/users/#{params[:username]}/vendors")
end

get '/users/:username/deals' do
	@purchases = Purchase.all
	@deals = []
	if params[:vendor_name] && Vendor.find_by(name: params[:vendor_name])
		@vendor = Vendor.find_by(name: params[:vendor_name])
		@deals = @vendor.deals
		@placeholder = @vendor.name
	elsif params[:item_name] && Item.find_by(name: params[:item_name])
		@item = Item.find_by(name: params[:item_name])
		@deals = @item.deals
		@placeholder = @item.name
	else
		@deals = User.find_by(username: params[:username]).deals
		@placeholder = "All Deals"
	end
	erb :deals
end

get '/users/:username/deals/:deal_id' do
	@deal_id = params[:deal_id]
	@vendors = Vendor.all.sort_by{|vendor|vendor.name.downcase}
	@items = Item.all.sort_by{|item|item.name.downcase}
	erb :update_deal
end

post '/users/:username/deals/:deal_id' do
	@deal = Deal.find(params[:deal_id])
	@deal.vendor_id = params[:vendor]
	@deal.item_id = params[:item]
	@deal.price = params[:price]
	@deal.save
	redirect("/users/#{params[:username]}/deals")
end

post '/users/:username/purchase/:id' do
	@user = User.find_by(username: params[:username])
	@purchase = Purchase.find_by(user_id: @user.id, deal_id: params[:id])
	if @purchase
		@purchase.total_purchases += 1
		@purchase.save
	else
		Purchase.create(user_id: @user.id, deal_id: params[:id], total_purchases: 1)
	end
	redirect("/users/#{@user.username}/deals")

end

get '/users/:username/deals/:deal_id/delete' do
	@deal = Deal.find(params[:deal_id])
	@deal.destroy
	redirect("/users/#{params[:username]}/deals")
end

get '/users/:username/purchases' do
	@purchases = @current_user.purchases
	erb :purchases
end

post '/create_item' do
	@item = Item.new(name: params[:name], description: params[:description])
	if @item.save
	elsif @item.name.nil?
		@errors << "Please enter an item name"
	else
		@errors << "Item already exists"
	end
	redirect("/users/#{@current_user.username}")
end

post '/create_vendor' do
	@vendor = Vendor.create(name: params[:name], user_id: @current_user.id)
	redirect("/users/#{@current_user.username}")
end

post '/create_deal' do
	@deal = Deal.create(vendor_id: params[:vendor], item_id: params[:item], price: params[:price])
	redirect("/users/#{@current_user.username}")
end

get '/logout' do
	session.clear
	redirect('/')
end



