class AddPriceToLineItems < ActiveRecord::Migration
  def self.up
    add_column :line_items, :price, :decimal, :precision => 8, :scale => 2
    
    LineItem.all.each do |item|
      item.price = item.product.price
    end
    
  end

  def self.down
    remove_column :line_items, :price
  end
end
