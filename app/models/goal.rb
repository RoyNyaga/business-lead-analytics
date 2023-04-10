class Goal < ApplicationRecord
  belongs_to :business
  has_many :weekly_data_entries, dependent: :destroy

  validates :quater_name, presence: true
  validates :budget, presence: true
  validates :projected_revenue, presence: true
  validates :products, presence: true
  validates :channels, presence: true
  validates :unique_code, uniqueness: { scope: :business_id,
    message: "This Quater already exist for this year, Please select another Quater." }
  validate :projected_leads_range

  before_validation :set_unique_code
  
  QUATER_OPTIONS = ["Q1", "Q2", "Q3", "Q4"]

  def set_unique_code
    self.unique_code = quater_name + " - " + Time.now.year.to_s
  end

  def projected_leads_range
    self.errors.add(:projected_leads, "Can not be less than 1") if projected_leads < 1
  end

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

  def weekly_data_product_initialize_hash
    product_hash = Hash.new
    products.split("-#-").map(&:strip).each do |product|
      product_hash[product] = 0
    end
    product_hash
  end

  def parse_channels_chart_data(in_percentage: false)
    data_set = weekly_data_channel_initialize_hash
    weekly_data_entries.each do |data|
      data.channel_leads_hash.each do |key, value|
        data_set[key] += value.to_i if data_set[key].present?
      end
    end

    in_percentage ? data_to_percentage(data_set) : data_set
  end

  def parse_leads_abandoned_leads_data(in_percentage: false)
    data_set = { "Leads" => actual_leads, "Abondoned Leads" => abandoned_leads }
    in_percentage ? data_to_percentage(data_set) : data_set
  end

  def data_to_percentage(data_set)
    sum = data_set.values.sum.to_f
    data_set.each do |key, value|
      data_set[key] = ((value.to_f/sum) * 100).round(2)
    end

    data_set
  end

  def parse_products_chart_data(in_percentage: false)
    data_set = weekly_data_product_initialize_hash
    weekly_data_entries.each do |data|
      data.product_leads_hash.each do |key, value|
        data_set[key] += value.to_i if data_set[key].present?
      end
    end

    in_percentage ? data_to_percentage(data_set) : data_set
  end
end
