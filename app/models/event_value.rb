class EventValue < ApplicationRecord
  has_one :working_day_prices, foreign_key: "working_day_price_id", class_name: "EventType"
  has_one :weekend_price, foreign_key: "weekend_price_id", class_name: "EventType"
  validates :base_price, :price_per_person, :overtime_rate, presence: true
end
