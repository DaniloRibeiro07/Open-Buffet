class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event_type_and_buffet, only: [:new, :create, :edit, :update]
  before_action :set_order, only: [:edit, :update, :show, :cancel]
  before_action :special_access, except: [:new, :index, :create]

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

  def edit
  end

  def update 
    @order.update(order_params)

    if params[:commit] == "Dentro do Buffet" || params[:commit] == "Em outro endereço"
      @order.inside_the_buffet = !@order.inside_the_buffet 
      return render 'edit'
    end

    if @order.update(order_params)
      redirect_to @order, alert: "Pedido Atualizado com sucesso"
    else 
      flash.now.notice = @order.errors.full_messages
      render 'edit'
    end
  end

  def index 
    if current_user.company
      @orders = current_user.buffet_registration.orders
    else
      @orders = current_user.orders
    end
  end

  def show 
    @event_type = @order.event_type
    @buffet_registration = @event_type.buffet_registration
  end

  def cancel 
    @order.canceled!
    redirect_to @order
  end

  private 

  def special_access
    if current_user.company? && current_user == @order.event_type.user
      return
    elsif current_user == @order.user
      return
    end
    redirect_to root_path
  end

  def set_order 
    @order = Order.find params[:id]
  end

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