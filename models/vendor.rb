class Vendor < ActiveRecord::Base
	belongs_to :user
	has_many :deals, dependent: :destroy
	has_many :items, :through => :deals

end