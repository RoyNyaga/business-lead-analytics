class Business < ApplicationRecord
  belongs_to :industry
  belongs_to :user
  has_many :channels, dependent: :destroy
  has_many :goals, dependent: :destroy
  has_many :products, dependent: :destroy

  validates :name, presence: true
  validates :products, presence: true
end
