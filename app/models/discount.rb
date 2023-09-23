class Discount < ApplicationRecord
  validates_presence_of :percentage,
                        :threshold,
                        :merchant_id

  belongs_to :merchant
  has_many :items, through: :merchant
  # add test for validations and relationships
end