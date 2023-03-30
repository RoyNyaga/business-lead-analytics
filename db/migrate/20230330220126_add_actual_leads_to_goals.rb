class AddActualLeadsToGoals < ActiveRecord::Migration[7.0]
  def change
    add_column :goals, :actual_leads, :integer, default: 0
  end
end
