class BuffetRegistration < ApplicationRecord
  belongs_to :payment_method, dependent: :destroy
  accepts_nested_attributes_for :payment_method

  belongs_to :user
  has_many :event_type
  validates :trading_name, :company_name, :phone, :cnpj, :public_place, :email,
            :address_number, :neighborhood, :state, :city, :zip, :description, presence: true
  validates :cnpj,  uniqueness: true

  
  
  def full_address 
    "#{public_place}, #{address_number}, #{zip}, #{city}-#{state}"
  end
end
