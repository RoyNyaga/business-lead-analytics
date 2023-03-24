class Product < ApplicationRecord
  belongs_to :business
  belongs_to :user
  has_many :weekly_data_entries
end
