class RemoveProductsFromBusinesses < ActiveRecord::Migration[7.0]
  def change
    remove_column :businesses, :products
  end
end
