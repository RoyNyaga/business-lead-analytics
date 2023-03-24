class Channel < ApplicationRecord
  belongs_to :business
  belongs_to :user
  has_many :weekly_data_entries

  validates :name, presence: true, uniqueness: { scope: :business_id, 
    message: ": Channel already Exist." }

end
