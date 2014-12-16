class Item < ActiveRecord::Base
	has_many :deals, dependent: :destroy 
	has_many :vendors, :through => :deals

end