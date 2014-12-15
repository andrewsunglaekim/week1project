class CreatePurchases < ActiveRecord::Migration
  def change
  	create_table :purchases do |t|
  		t.belongs_to :user
  		t.belongs_to :deal
  		t.integer :total_purchases
  		t.timestamps
  	end
  end
end
