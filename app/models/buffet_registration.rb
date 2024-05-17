class BuffetRegistration < ApplicationRecord
  belongs_to :payment_method, dependent: :destroy
  accepts_nested_attributes_for :payment_method
  belongs_to :user
  has_many :event_types
  has_many :orders
  has_many :evaluations, through: :orders
  validates :trading_name, :company_name, :phone, :cnpj, :public_place, :email,
            :address_number, :neighborhood, :state, :city, :zip, :description, presence: true
  validates :cnpj,  uniqueness: true

  enum available: {desactive: 0 , active: 1}
  
  def full_address 
    "#{public_place}, #{address_number}, #{zip}, #{city}-#{state}"
  end
end
