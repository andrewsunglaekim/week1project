class Deal < ActiveRecord::Base
	has_many :purchases
	belongs_to :vendor
	belongs_to :item

end