class AddContactedLeadsToGoals < ActiveRecord::Migration[7.0]
  def change
    add_column :goals, :contacted_leads, :integer
  end
end
