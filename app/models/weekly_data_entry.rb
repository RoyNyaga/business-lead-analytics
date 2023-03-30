class WeeklyDataEntry < ApplicationRecord
  belongs_to :goal
  belongs_to :business
  belongs_to :user

  before_save :set_leads_per_week, :set_conversion_rate

  def parse_channel_leads(params)
    leads_per_channel = []
    business.channels.each do |channel|
      leads_per_channel << { "#{channel.name}" => params["#{channel.name}"] }
    end

    self.channel_leads_per_week = leads_per_channel
  end

  def sum_weekly_channel_leads
    parsed_channels = self.channel_leads_per_week.map{ |c| eval(c) }
    parsed_channels.map{ |c| c.values.first.to_i }.sum
  end

  def set_leads_per_week
    self.leads_per_week = sum_weekly_channel_leads
  end

  def parse_product_leads(params)
    leads_per_product = []
    business.products.each do |product|
      leads_per_product << { "#{product.name}" => params["#{product.name}"] }
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
end
