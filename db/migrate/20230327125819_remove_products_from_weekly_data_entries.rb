class RemoveProductsFromWeeklyDataEntries < ActiveRecord::Migration[7.0]
  def change
    remove_column :weekly_data_entries, :product_id
  end
end
