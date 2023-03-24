class Goal < ApplicationRecord
  belongs_to :business
  
  QUATER_OPTIONS = ["Q1", "Q2", "Q3", "Q4"]
end
