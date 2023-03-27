class AddProductLeadsPerWeek < ActiveRecord::Migration[7.0]
  def change
    add_column :weekly_data_entries, :product_leads_per_week, :text, array: true, default: []
  end
end
