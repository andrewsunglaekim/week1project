class Vendor < ActiveRecord::Base
	belongs_to :user
	has_many :deals
	has_many :items, :through => :deals

end