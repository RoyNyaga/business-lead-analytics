class Goal < ApplicationRecord
  belongs_to :business
  has_many :weekly_data_entries

  QUATER_OPTIONS = ["Q1", "Q2", "Q3", "Q4"]
end
