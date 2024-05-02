class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def new
    return root_path if current_user.company
    @event_type = EventType.find(params[:event_type_id])
    @buffet_registration = @event_type.buffet_registration
    @order = Order.new
  end
  
end