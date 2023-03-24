class CreateWeeklyDataEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :weekly_data_entries do |t|
      t.references :goal, null: false, foreign_key: true
      t.references :business, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :channel, null: false, foreign_key: true
      t.integer :leads_per_week
      t.integer :contacted_leads
      t.string :paid_customers
      t.float :budget_expences
      t.float :revenue
      t.float :conversion_rate

      t.timestamps
    end
  end
end
