class AddAbandonedLeadsToGoals < ActiveRecord::Migration[7.0]
  def change
    add_column :goals, :abandoned_leads, :integer, default: 0
  end
end
