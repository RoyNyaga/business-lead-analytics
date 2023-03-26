class Remove < ActiveRecord::Migration[7.0]
  def change
    remove_column :weekly_data_entries, :channel_id
  end
end
