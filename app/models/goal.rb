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
end
