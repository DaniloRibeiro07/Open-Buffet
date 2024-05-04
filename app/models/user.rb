class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, :last_name, presence: true
  validates :company, inclusion: [true, false]
  has_one :buffet_registration
  has_many :event_types

  has_many :orders
  has_one :client_datum  
  accepts_nested_attributes_for :client_datum

  before_validation :create_cpf_client
 
  
  def create_cpf_client 
    if !self.company && !self.client_datum
      self.build_client_datum
    end
  end

  def description 
    account_type = (company ? "Empresa" : "Cliente")
    "#{name} |Conta #{account_type}|"
  end


end
