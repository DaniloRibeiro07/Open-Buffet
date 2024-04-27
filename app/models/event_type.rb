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

  def location_is_mandatory
    unless self.insider || self.outsider
      self.errors.add :location, 'onde o serviço pode ser ofertado deve ser marcado'
    end
  end
end
