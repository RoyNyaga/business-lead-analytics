class Goal < ApplicationRecord
  belongs_to :business
  has_many :weekly_data_entries, dependent: :destroy

  QUATER_OPTIONS = ["Q1", "Q2", "Q3", "Q4"]

  def channel_arr
    channels.split("-#-").map(&:strip)
  end

  def product_arr
    products.split("-#-").map(&:strip)
  end

  def update_related_fields_based_on_weekly_data_changes
    @data = weekly_data_entries
    if @data.size > 0
      self.actual_leads = @data.map(&:leads_per_week).sum
      self.contacted_leads = @data.map(&:contacted_leads).sum
      self.revenue = @data.map(&:revenue).sum
      self.conversion_rate = @data.map(&:conversion_rate).sum / @data.count
      save
    end
  end

  def abandoned_leads
    actual_leads - contacted_leads
  end

  def projected_leads # overide projected_leads data type, changing it from string to integer
    super.to_i
  end

  def lead_difference
    actual_leads - projected_leads
  end

  def lead_progress
    progress = (actual_leads.to_f / projected_leads.to_f) * 100
    progress.round
  end

  def weekly_data_channel_initialize_hash
    channel_hash = Hash.new
    channels.split("-#-").map(&:strip).each do |channel|
      channel_hash[channel] = 0
    end
    channel_hash
  end

  def parse_channels_chart_data
    data_set = weekly_data_channel_initialize_hash
    weekly_data_entries.each do |data|
      data.channel_leads_hash.each do |key, value|
        data_set[key] += value.to_i
      end
    end
    data_set
  end
end
