class Review < ApplicationRecord
  belongs_to :list

  validates :comment, :rating, presence: true
  validates :rating, numericality: { in: 0..5, only_integer: true }
end
