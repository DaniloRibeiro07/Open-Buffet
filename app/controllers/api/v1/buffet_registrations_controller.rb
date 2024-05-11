class Api::V1::BuffetRegistrationsController < ActionController::API
  def index 
    filter = params[:filter]
    if filter
      result = BuffetRegistration.where('trading_name LIKE ?', "%#{filter}%")
      if result.any? 
        render status: 200, json: result.as_json(only: [:id, :trading_name, :city, :state])
      else
        render status: 406, json: {"errors": "Não foi encontrados registros de #{filter}"}
      end
    else 
      render status:200, json: BuffetRegistration.all.as_json(only: [:id, :trading_name, :city, :state])
    end
  end
end