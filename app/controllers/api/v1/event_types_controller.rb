class Api::V1::EventTypesController < ActionController::API
  def index 
    buffet = BuffetRegistration.find_by(id: params[:buffet_registration_id]) 
    if buffet 
      if buffet.event_types.any?
        render status: 200, json: buffet.event_types.as_json(include: 
          {weekend_price: {only: [:base_price, :price_per_person, :overtime_rate]},
          working_day_price: {only: [:base_price, :price_per_person, :overtime_rate]}},
          except: [:created_at, :updated_at, :working_day_price_id, :weekend_price_id, :user_id])

      else  
        render status: 200, json: []
      end
    else 
      render status: 406, json: {"errors": "Não há buffet com o id: #{params[:buffet_registration_id]}"}
    end
  end
end