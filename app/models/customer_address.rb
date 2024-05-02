class CustomerAddress < ApplicationRecord
  has_one :order
end
