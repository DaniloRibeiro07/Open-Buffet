class Order < ApplicationRecord
  has_many :chats
  has_one :evaluation
  belongs_to :user, optional: true
  belongs_to :buffet_registration, optional: true
  belongs_to :event_type, optional: true
  belongs_to :customer_address, dependent: :destroy, optional: true
  belongs_to :extra_service, dependent: :destroy , optional: true

  accepts_nested_attributes_for :customer_address
  accepts_nested_attributes_for :extra_service

  validates :user, :buffet_registration, :event_type, presence: true , if: -> { validation_context != :api }

  validates :date, :amount_of_people, presence: true

  validates :inside_the_buffet, inclusion: [true, false], if: -> { validation_context != :api }

  validates :duration, comparison: { greater_than: 1 }, if: -> { validation_context != :api }
  validate :number_of_people_ltd
  validate :customer_address_required?, if: -> { validation_context != :api }
  validate :user_is_client?, if: -> { validation_context != :api }
  validate :event_type_accepts_inside_the_buffet?, if: -> { validation_context != :api }
  validate :final_valid_value, if: -> { validation_context != :api }
  validate :justification_final_value_required?, if: -> { validation_context != :api }
  validate :final_value_required, if: -> { validation_context != :api }
  validate :expiration_date_required, if: -> { validation_context != :api }
  validate :mandatory_payment_method, if: -> { validation_context != :api }
  validate :order_confirmed_before_expiration_date?, if: -> { validation_context != :api }
  validate :date_greater_than_date_current
  
  before_create :initial_status, :code_generator
  before_save :calculate_calculated_value
  before_validation :reset_final_value_in_waiting_for_buffet_review



  enum :status, "waiting_for_buffet_review": 1, "waiting_for_client_review": 2,  "approved": 3, "canceled": 4



  def type_of_day
    if self.date.sunday? || self.date.saturday? 
      return "Final de Semana"
    else
      return "Dia útil"
    end
  end


  def calculate_calculated_value

    if type_of_day == "Final de Semana" && self.event_type.different_weekend
      base_price = self.event_type.weekend_price.base_price
      extra_people_value = self.event_type.weekend_price.price_per_person
      extra_minute_value = self.event_type.weekend_price.overtime_rate / 60
    else
      base_price = self.event_type.working_day_price.base_price
      extra_people_value = self.event_type.working_day_price.price_per_person
      extra_minute_value = self.event_type.working_day_price.overtime_rate / 60
    end

    extra_people = self.amount_of_people - self.event_type.minimum_quantity
    extra_minute_time = self.duration - self.event_type.duration
    extra_minute_time = 0 if extra_minute_time < 0

    self.calculated_value = ( base_price + extra_minute_value * extra_minute_time + extra_people * extra_people_value ).ceil(2)
  end
  
  private 

  def date_greater_than_date_current
    if !self.seed && self.date && self.date <= Date.current
      self.errors.add :date, "deve ser maior do que hoje (#{I18n.l(Date.current)})"
    end
  end

  def order_confirmed_before_expiration_date?
    if !self.seed && self.approved? && Date.current >= self.expiration_date
      self.errors.add :order, "vencido, pedido cancelado."
    end
  end

  def mandatory_payment_method
    if self.final_value && !self.payment_method 
      self.errors.add :payment_method, "deve ser especificado"
    end
  end

  def expiration_date_required
    if !self.seed && self.final_value && (!self.expiration_date || self.expiration_date > self.date || self.expiration_date < Date.current)
      self.errors.add :expiration_date, "deve ser menor ou igual a data do evento e maior ou igual a data de hoje"
    end
  end

  def final_value_required
    if self.id && !self.canceled? && !self.waiting_for_buffet_review? && self.final_value.nil?
      self.errors.add :final_value, "obrigatório"
    end
  end

  def reset_final_value_in_waiting_for_buffet_review
    if self.waiting_for_buffet_review?
      self.final_value = nil
      self.justification_final_value = nil   
      self.payment_method = nil
    end
  end

  def final_valid_value
    if self.final_value && self.final_value < 0 
      self.errors.add(:final_value, "precisa ser maior ou igual a 0")
    end
  end

  def justification_final_value_required?
    if self.final_value && self.final_value >= 0 && self.final_value != self.calculated_value && (self.justification_final_value.nil? || self.justification_final_value == '')
      self.errors.add(:justification_final_value, "precisa ser informada caso o valor seja diferente do calculado")
    end
  end
  
  def event_type_accepts_inside_the_buffet?
    if self.event_type && !self.event_type.insider && self.inside_the_buffet
      self.errors.add :inside_the_buffet, "não pode ser dentro do buffet"
    end
  end

  



  def initial_status
    self.status = 1 
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
      if self.amount_of_people && self.event_type.minimum_quantity && self.event_type.minimum_quantity > self.amount_of_people 
        self.errors.add  :amount_of_people, "Deve ser maior ou igual a #{self.event_type.minimum_quantity}" 
      end
      if  self.amount_of_people && self.event_type.maximum_quantity && self.event_type.maximum_quantity < self.amount_of_people
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
