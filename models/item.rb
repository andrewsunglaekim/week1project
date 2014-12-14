class Item < ActiveRecord::Base
	has_many :deals
	has_many :vendors, :through => :deals

end