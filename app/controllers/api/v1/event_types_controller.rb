class Api::V1::EventTypesController < Api::V1::ApiController
  def index 
    buffet = BuffetRegistration.active.find_by(id: params[:buffet_registration_id]) 
    if buffet 
      if buffet.event_types.active.any?
        render status: 200, json: buffet.event_types.active.as_json(include: 
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