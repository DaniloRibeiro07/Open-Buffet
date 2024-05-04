class CustomerAddress < ApplicationRecord
  has_one :order
  validates :public_place, :neighborhood, :state, :zip, :city, :address_number, presence: true
end
