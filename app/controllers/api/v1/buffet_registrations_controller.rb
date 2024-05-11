class Api::V1::BuffetRegistrationsController < ActionController::API
  def index 
    filter = params[:filter]
    if filter
      result = BuffetRegistration.where('trading_name LIKE ?', "%#{filter}%")
      if result.any? 
        render status: 200, json: result.map(&:trading_name)
      else
        render status: 406, json: {"errors": "Não foi encontrados registros de #{filter}"}
      end
    else 
      render status:200, json: BuffetRegistration.all.map(&:trading_name)
    end
  end
end