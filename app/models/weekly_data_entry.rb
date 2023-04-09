class WeeklyDataEntry < ApplicationRecord
  belongs_to :goal
  belongs_to :business
  belongs_to :user

  before_save :set_leads_per_week, :set_conversion_rate
  after_save :update_related_goal_attributes

  validate :validate_product_channel_leads_equality

  scope :business_yearly_data, -> (business_id, date) { where("date >= '#{date.beginning_of_year}' AND date <= '#{date.end_of_year}'") }

  def validate_product_channel_leads_equality
    errors.add(:channel_leads_and_product_leads, "Product Leads should equal Channel leads") unless sum_weekly_channel_leads == sum_weekly_product_leads
  end

  def parse_channel_leads(params)
    leads_per_channel = []
    business.channels.each do |channel|
      leads_per_channel << { "#{channel.name}" => params["#{channel.name}"] } if goal.channel_arr.include?(channel.name)
    end

    self.channel_leads_per_week = leads_per_channel
  end

  def sum_weekly_channel_leads
    parsed_channels = self.channel_leads_per_week.map{ |c| eval(c) }
    parsed_channels.map{ |c| c.values.first.to_i }.sum
  end

  def sum_weekly_product_leads
    parsed_products = self.product_leads_per_week.map{ |c| eval(c) }
    parsed_products.map{ |c| c.values.first.to_i }.sum
  end

  def set_leads_per_week
    self.leads_per_week = sum_weekly_channel_leads
  end

  def parse_product_leads(params)
    leads_per_product = []
    business.products.each do |product|
      leads_per_product << { "#{product.name}" => params["#{product.name}"] } if goal.product_arr.include?(product.name)
    end

    self.product_leads_per_week = leads_per_product
  end

  def parse_leads(params)
    parse_channel_leads(params)
    parse_product_leads(params)
  end

  def calc_conversion_rate
    (paid_customers.to_f / sum_weekly_channel_leads.to_f) * 100
  end

  def set_conversion_rate
    self.conversion_rate = calc_conversion_rate
  end

  def channel_leads_array_of_hashes
    channel_leads_per_week.map{ |channel| eval(channel) }
  end

  def product_leads_array_of_hashes
    product_leads_per_week.map{ |product| eval(product) }
  end

  def channel_leads_hash # merge channel_leads_per_week into a big hash
    channel_leads_array_of_hashes.reduce(Hash.new) { |main_hash, other_hash| main_hash.merge(other_hash) }
  end

  def product_leads_hash # merge product_leads_per_week into a big hash
    product_leads_array_of_hashes.reduce(Hash.new) { |main_hash, other_hash| main_hash.merge(other_hash) }
  end

  def self.goal_ids(data_entries)
    data_entries.map(&:goal_id).uniq
  end

  def self.yearly_actual_leads(data_entries)
    Goal.where(id: self.goal_ids(data_entries)).map(&:actual_leads).sum
  end

  def self.yearly_project_leads(data_entries)
    Goal.where(id: self.goal_ids(data_entries)).map(&:projected_leads)
  end

  def self.yearly_lead_difference(data_entries)
    self.yearly_actual_leads(data_entries) - self.yearly_project_leads(data_entries)
  end

  def selfyearly_lead_progress(data_entries)
    progress = (self.yearly_actual_leads(data_entries).to_f / self.year_projected_leads(data_entries).to_f) * 100
    progress.round
  end

  def self.yearly_conversion_rate(data_entries)
    data_entries.map(&:conversion_rate).sum / data_entries.count
  end

  private 

  def update_related_goal_attributes
    goal.update_related_fields_based_on_weekly_data_changes
  end
end
