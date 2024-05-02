class Order < ApplicationRecord
  belongs_to :buffet
  belongs_to :event_type
  belongs_to :customer_address
  accepts_nested_attributes_for :customer_address
end
