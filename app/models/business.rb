class Business < ApplicationRecord
  belongs_to :industry
  belongs_to :user

  validates :name, presence: true
  validates :products, presence: true
end
