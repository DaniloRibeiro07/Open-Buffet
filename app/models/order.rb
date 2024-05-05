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
  validate :event_type_accepts_inside_the_buffet?

  before_create :initial_status, :code_generator
  before_save :calculate_calculated_value


  enum :status, "waiting_for_buffet_review": 1, "waiting_for_client_review": 2,  "approved": 3, "canceled": 4



  def type_of_day
    if self.date.sunday? || self.date.saturday? 
      return "Final de Semana"
    else
      return "Dia útil"
    end
  end


  private 
  
  def event_type_accepts_inside_the_buffet?
    if self.event_type && !self.event_type.insider && self.inside_the_buffet
      self.errors.add :inside_the_buffet, "não pode ser dentro do buffet"
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

    self.calculated_value = base_price + extra_minute_value * extra_minute_time + extra_people * extra_people_value
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
