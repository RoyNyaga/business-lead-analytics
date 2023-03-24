class WeeklyDataEntry < ApplicationRecord
  belongs_to :goal
  belongs_to :business
  belongs_to :user
  belongs_to :product
  belongs_to :channel
end
