class AddConversionAndRevenueToGoals < ActiveRecord::Migration[7.0]
  def change
    add_column :goals, :conversion_rate, :float, default: 0.0
    add_column :goals, :revenue, :integer
  end
end
