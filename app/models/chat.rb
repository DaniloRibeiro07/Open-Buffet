class Chat < ApplicationRecord
  belongs_to :order
  validates :message, presence: true 
  validates :to_company, inclusion: [true, false]
end
