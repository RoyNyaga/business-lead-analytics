class Industry < ApplicationRecord
  has_many :businesses

  validates :name, presence: true, uniqueness: { scope: :business_id, 
    message: ": Industry already Exist." }
end
