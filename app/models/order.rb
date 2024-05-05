class Order < ApplicationRecord
  belongs_to :user
  belongs_to :buffet_registration
  belongs_to :event_type
  belongs_to :customer_address, dependent: :destroy, optional: true
  belongs_to :extra_service, dependent: :destroy , optional: true

  accepts_nested_attributes_for :customer_address
  accepts_nested_attributes_for :extra_service

  validates :date, :amount_of_people, presence: true

  validates :inside_the_buffet, inclusion: [true, false]

  validates :date, comparison: { greater_than: Date.current, message: "deve ser maior do que hoje (#{I18n.l(Date.current)})" }
  validates :duration, comparison: { greater_than: 1 } 
  validate :number_of_people_ltd
  validate :customer_address_required?
  validate :user_is_client?

  after_create :initial_status, :code_generator

  enum :status, "waiting_for_review": 1, "approved": 2, "rejected": 3

  private 

  def initial_status
    self.waiting_for_review!
  end

  def user_is_client?
    if self.user && self.user.company != false
      self.errors.add :user, "precisa ser um cliente"
    end
  end

  def customer_address_required?
    if self.inside_the_buffet == false && !self.customer_address 
      self.errors.add :customer_address, "obrigatório"
    end
  end

  def number_of_people_ltd 
    if self.event_type
      if self.amount_of_people && self.event_type.minimum_quantity && self.event_type.minimum_quantity >= self.amount_of_people 
        self.errors.add  :amount_of_people, "Deve ser maior ou igual a #{self.event_type.minimum_quantity}" 
      end
      if  self.amount_of_people && self.event_type.maximum_quantity && self.event_type.maximum_quantity <= self.amount_of_people
        self.errors.add  :amount_of_people, "Deve ser menor ou igual a #{self.event_type.maximum_quantity}" 
      end
    end
  end

  def code_generator
    cod = SecureRandom.alphanumeric(8).upcase
    while Order.find_by(code: cod)  
      cod = SecureRandom.alphanumeric(8).upcase
    end
    self.code = cod
  end

end
