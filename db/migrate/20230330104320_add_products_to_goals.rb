class AddProductsToGoals < ActiveRecord::Migration[7.0]
  def change
    add_column :goals, :products, :string
  end
end
