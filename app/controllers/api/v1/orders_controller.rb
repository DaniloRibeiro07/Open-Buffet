class Api::V1::OrdersController < Api::V1::ApiController
  def create 
    event_type = EventType.find_by(id: params[:event_type_id])
    
    if event_type
      if !params[:date] || !params[:amount_of_people]
        render status: 406, json: {"errors": "Data e quantidade de pessoas não pode ficar em branco"}
      else
        if(Order.approved.find_by(date: params[:date]))
          render status: 409, json: {"errors": "Já há um pedido aprovado neste dia"}
        else
          prior_value = Order.new(event_type: event_type, amount_of_people: params[:amount_of_people], 
                        duration: 2, date: params[:date]).calculate_calculated_value
          render status: 200, json: {"prior_value": prior_value}
        end
      end
    else
      render status: 406, json: {"errors": "Não há um tipo de evento com o id: #{params[:event_type_id]}"}
    end

  end
end