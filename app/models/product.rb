class Product < ApplicationRecord
  belongs_to :business
  belongs_to :user

  validates :name, presence: true, uniqueness: { scope: :business_id, 
    message: ": Product already Exist." }

  before_save :strip_out_white_spaces

  private

  def strip_out_white_spaces
    self.name = name.strip
  end
end
