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

  def set_actual_leads
    self.actual_leads = weekly_data_entries.map(&:leads_per_week).sum
    save
  end

  def set_contacted_leads
    self.contacted_leads = weekly_data_entries.map(&:contacted_leads).sum
    save
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
