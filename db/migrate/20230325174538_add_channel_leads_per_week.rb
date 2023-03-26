class AddChannelLeadsPerWeek < ActiveRecord::Migration[7.0]
  def change
    add_column :weekly_data_entries, :channel_leads_per_week, :text, array: true, default: []
  end
end
