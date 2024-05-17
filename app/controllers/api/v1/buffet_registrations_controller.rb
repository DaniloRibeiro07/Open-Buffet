class Api::V1::BuffetRegistrationsController < Api::V1::ApiController
  def index 
    filter = params[:filter]
    if filter
      result = BuffetRegistration.active.where('trading_name LIKE ?', "%#{filter}%")
      if result.any? 
        render status: 200, json: result.as_json(only: [:id, :trading_name, :city, :state])
      else
        render status: 406, json: {"errors": "Não foi encontrados registros de #{filter}"}
      end
    else 
      render status:200, json: BuffetRegistration.all.active.as_json(only: [:id, :trading_name, :city, :state])
    end
  end

  def show 
    buffet = BuffetRegistration.find_by(id: params[:id])

    if buffet 
      render status: 200, json: buffet.as_json(except: ['created_at', 'updated_at' , 'cnpj', 'company_name', 'user_id', 'payment_method_id'],
        include: {payment_method: {except:['id' , 'created_at', 'updated_at'] } , event_types: {only: ['name', 'id']}})
    else
      render status: 406, json: {"errors": "Não há buffet com o id: #{params[:id]}"}
    end
  end
end