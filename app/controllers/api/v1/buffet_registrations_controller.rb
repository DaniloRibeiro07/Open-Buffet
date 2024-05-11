class Api::V1::BuffetRegistrationsController < ActionController::API
  def index 
    render status:200, json: BuffetRegistration.all.map(&:trading_name)
  end
end