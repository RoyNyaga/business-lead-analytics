class WeeklyDataEntry < ApplicationRecord
  belongs_to :goal
  belongs_to :business
  belongs_to :user

  before_save :set_leads_per_week, :set_conversion_rate
  after_save :update_related_goal_attributes

  validate :product_channel_leads_equality

  scope :business_yearly_data, -> (business_id, date) { where("business_id = #{business_id} AND date >= '#{date.beginning_of_year}' AND date <= '#{date.end_of_year}'") }

  def product_channel_leads_equality
    errors.add(:channel_leads_and_product_leads, "Product Leads should equal Channel leads") unless sum_weekly_channel_leads == sum_weekly_product_leads
  end

  def validate_

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

  def self.yearly_contacted_leads(data_entries)
    data_entries.map(&:contacted_leads).sum
  end

  def self.yearly_projected_leads(data_entries)
    Goal.where(id: self.goal_ids(data_entries)).map(&:projected_leads).sum
  end

  def self.yearly_lead_difference(data_entries)
    self.yearly_actual_leads(data_entries) - self.yearly_projected_leads(data_entries)
  end

  def self.yearly_lead_progress(data_entries)
    progress = (self.yearly_actual_leads(data_entries).to_f / self.yearly_projected_leads(data_entries).to_f) * 100
    progress.round
  end

  def self.yearly_conversion_rate(data_entries)
    data_entries.map(&:conversion_rate).sum / data_entries.count
  end

  def self.yearly_data_channel_initialize_hash(data_entries)
    channel_hash = Hash.new
    data_entry = data_entries.first
    date_to_query = data_entry.date
    @business_id = data_entry.business_id
    goals = Goal.where("business_id = #{@business_id} AND created_at >= '#{date_to_query.beginning_of_year}' AND created_at <= '#{date_to_query.end_of_year}'")
    goals.each do |goal|
      goal.channels.split("-#-").map(&:strip).each do |channel|
        channel_hash[channel] = 0
      end
    end

    channel_hash
  end

  def self.yearly_parse_channels_chart_data(data_entries, in_percentage: false)
    data_set = self.yearly_data_channel_initialize_hash(data_entries)
    data_entries.each do |data|
      data.channel_leads_hash.each do |key, value|
        data_set[key] += value.to_i if data_set[key].present?
      end
    end

    in_percentage ? self.data_to_percentage(data_set) : data_set
  end

  def self.yearly_data_product_initialize_hash(data_entries)
    product_hash = Hash.new
    data_entry = data_entries.first
    date_to_query = data_entry.date
    @business_id = data_entry.business_id 
    goals = Goal.where("business_id = #{@business_id} AND created_at >= '#{date_to_query.beginning_of_year}' AND created_at <= '#{date_to_query.end_of_year}'")
    goals.each do |goal|
      goal.products.split("-#-").map(&:strip).each do |product|
        product_hash[product] = 0
      end
    end

    product_hash
  end

  def self.yearly_parse_products_chart_data(data_entries, in_percentage: false)
    data_set = self.yearly_data_product_initialize_hash(data_entries)
    data_entries.each do |data|
      data.product_leads_hash.each do |key, value|
        data_set[key] += value.to_i if data_set[key].present?
      end
    end

    in_percentage ? self.data_to_percentage(data_set) : data_set
  end

  def self.data_to_percentage(data_set)
    sum = data_set.values.sum.to_f
    data_set.each do |key, value|
      data_set[key] = ((value.to_f/sum) * 100).round(2)
    end

    data_set
  end

  def self.yearly_abandoned_leads(data_entries)
    self.yearly_actual_leads(data_entries) - self.yearly_contacted_leads(data_entries)
  end

  def self.parse_yearly_contacted_vs_abandoned_leads(data_entries, in_percentage: false)
    if in_percentage
      sum = (self.yearly_contacted_leads(data_entries) + self.yearly_abandoned_leads(data_entries)).to_f
      contacted_leads_percent = (self.yearly_contacted_leads(data_entries).to_f / sum) * 100
      abandoned_leads_percent = (self.yearly_abandoned_leads(data_entries).to_f / sum) * 100
      { "Contacted Leads" => contacted_leads_percent.round(2), "Abondoned Leads" => abandoned_leads_percent.round(2)}
    else
      { "Contacted Leads" => self.yearly_contacted_leads(data_entries), "Abondoned Leads" => self.yearly_abandoned_leads(data_entries) }
    end
  end

  private 

  def update_related_goal_attributes
    goal.update_related_fields_based_on_weekly_data_changes
  end
end
