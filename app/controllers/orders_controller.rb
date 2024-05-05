class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  before_action :set_event_type_and_buffet, only: [:new, :create]

  def new
    return redirect_to root_path if current_user.company
    @order = Order.new
  end

  def create 
    @order = @event_type.orders.build(order_params)

    if params[:commit] == "Dentro do Buffet" || params[:commit] == "Em outro endereço"
      @order.inside_the_buffet = !@order.inside_the_buffet 
      return render 'new'
    end


    if @order.save
      redirect_to @order, alert: "Pedido criado com sucesso"
    else 
      flash.now.notice = @order.errors.full_messages
      render 'new'
    end

  end

  def show 
    
  end

  private 

  def set_event_type_and_buffet
    @event_type = EventType.find(params[:event_type_id])
    @buffet_registration = @event_type.buffet_registration

  end

  def order_params
    order_params =  params.require(:order).permit(:amount_of_people, :duration, :date, :observation, 
    extra_service_attributes: [:decoration, :valet, :alcoholic_beverages])

    if @event_type.insider && @event_type.outsider
      order_params.merge!(params.require(:order).permit(:inside_the_buffet))
      unless order_params[:inside_the_buffet] == 'true'
        order_params.merge!(params.require(:order).permit(customer_address_attributes:[:public_place, 
              :neighborhood, :state, :city, :zip, :address_number, :complement]))
      end
    elsif @event_type.insider && !@event_type.outsider
      order_params.merge! ( {:inside_the_buffet => true} )
    else
      order_params.merge! ( {:inside_the_buffet => false} )
      order_params.merge! (params.require(:order).permit(customer_address_attributes:[:public_place, 
          :neighborhood, :state, :city, :zip, :address_number, :complement]))
    end

    order_params.merge!  ( {:buffet_registration => @event_type.buffet_registration, :user => current_user})
    order_params
  end
  
end