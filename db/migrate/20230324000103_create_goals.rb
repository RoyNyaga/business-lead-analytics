class CreateGoals < ActiveRecord::Migration[7.0]
  def change
    create_table :goals do |t|
      t.string :quater_name
      t.string :projected_leads
      t.float :budget
      t.float :projected_conversion_rate
      t.float :projected_revenue
      t.string :channels
      t.references :user, null: false, foreign_key: true
      t.references :business, null: false, foreign_key: true

      t.timestamps
    end
  end
end
