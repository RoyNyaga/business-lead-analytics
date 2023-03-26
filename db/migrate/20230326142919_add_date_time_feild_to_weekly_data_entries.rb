class AddDateTimeFeildToWeeklyDataEntries < ActiveRecord::Migration[7.0]
  def change
    add_column :weekly_data_entries, :date, :date
  end
end
