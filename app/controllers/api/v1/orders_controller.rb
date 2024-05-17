class Api::V1::OrdersController < Api::V1::ApiController
  def create 
    event_type = EventType.active.find_by(id: params[:event_type_id])
    
    if event_type && event_type.buffet_registration.active?
      if(Order.approved.find_by(date: params[:date]))
        render status: 409, json: {"errors": "Já há um pedido aprovado neste dia"}
      else
        order = Order.new(event_type: event_type, amount_of_people: params[:amount_of_people], 
                      duration: 2, date: params[:date])
        if order.valid?(:api)
          render status: 200, json: {"prior_value": order.calculate_calculated_value}
        else
          render status: 412, json: {errors: order.errors.full_messages}
        end
      end
    else
      render status: 406, json: {"errors": "Não há um tipo de evento com o id: #{params[:event_type_id]}"}
    end

  end
end