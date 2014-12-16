class Deal < ActiveRecord::Base
	has_many :purchases, dependent: :destroy
	belongs_to :vendor
	belongs_to :item

end