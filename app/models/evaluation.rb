class Evaluation < ApplicationRecord
  belongs_to :order
  validates :score, comparison: {greater_than_or_equal_to: 0, less_than_or_equal_to: 5}
  
  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize_to_limit: [200, nil]
    attachable.variant :medium, resize_to_limit: [500, nil]
  end
end
