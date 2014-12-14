class User < ActiveRecord::Base
	has_many :vendors
	has_many :purchases
	has_many :deals, :through => :vendors
end