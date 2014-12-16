class Item < ActiveRecord::Base
	has_many :deals, dependent: :destroy 
	has_many :vendors, :through => :deals
	validates :name, uniqueness: true
	validates :name, presence: true

end