class Business < ApplicationRecord
  belongs_to :industry
  belongs_to :user
  has_many :channels
  has_many :goals

  validates :name, presence: true
  validates :products, presence: true
end
