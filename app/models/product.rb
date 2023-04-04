class Product < ApplicationRecord
  belongs_to :business
  belongs_to :user

  validates :name, presence: true, uniqueness: { scope: :business_id, 
    message: ": Product already Exist." }
end
