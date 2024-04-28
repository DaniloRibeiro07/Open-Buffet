class EventType < ApplicationRecord
  belongs_to :user
  belongs_to :buffet_registration
  validates :name, :user_id, :description, :minimum_quantity, :maximum_quantity,
            :duration, :menu, presence: true
  validates :maximum_quantity, comparison: { greater_than_or_equal_to: :minimum_quantity }
  validate  :location_is_mandatory

  belongs_to :working_day_price, class_name: "EventValue", dependent: :destroy
  belongs_to :weekend_price, class_name: "EventValue", dependent: :destroy

  accepts_nested_attributes_for :working_day_price, :weekend_price

  before_validation :weekend_price_necessary?

  private

  def location_is_mandatory
    unless self.insider || self.outsider
      self.errors.add :location, 'onde o serviço pode ser ofertado deve ser marcado'
    end
  end

  def weekend_price_necessary?
    unless self.different_weekend
      unless self.weekend_price
        self.create_weekend_price(base_price: 0, price_per_person: 0, overtime_rate: 0)
      else
        base_price = self.weekend_price.base_price.nil? ? 0 : self.weekend_price.base_price
        price_per_person = self.weekend_price.price_per_person.nil? ? 0 : self.weekend_price.price_per_person
        overtime_rate = self.weekend_price.overtime_rate.nil? ? 0 : self.weekend_price.overtime_rate
        self.weekend_price.update(base_price: base_price, price_per_person: price_per_person, overtime_rate: overtime_rate)
      end
    end
  end

end
