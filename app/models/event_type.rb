class MandatoryLocalToWorkMethod < ActiveModel::Validator
  def validate(record)
    unless record.insider || record.outsider
      record.errors.add :O_local, 'onde o serviço pode ser ofertado deve ser marcado'
    end
  end
end

class EventType < ApplicationRecord
  belongs_to :user
  belongs_to :buffet_registration
  validates :name, :user_id, :description, :minimum_quantity, :maximum_quantity,
            :duration, :menu, presence: true
  validates :maximum_quantity, comparison: { greater_than_or_equal_to: :minimum_quantity }
  validates_with MandatoryLocalToWorkMethod
end