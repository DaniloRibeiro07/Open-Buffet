class HomeController < ApplicationController
  def index
    if user_signed_in? && current_user.company
      @buffet_registration = BuffetRegistration.find_by(user: current_user.id)
      @event_types =  EventType.where("user_id = #{current_user.id}")
    end
  end
end