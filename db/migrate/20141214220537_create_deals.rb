class CreateDeals < ActiveRecord::Migration
  def change
  	create_tables :deals do |t|
  		t.belongs_to :item
  		t.belongs_to :vendor
  		t.integer :price
  		t.timestamp
  	end
  end
end
