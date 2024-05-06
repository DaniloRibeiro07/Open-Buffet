class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event_type_and_buffet, only: [:new, :create, :edit, :update]
  before_action :set_order, only: [:edit, :update, :show, :cancel, :set_final_value, :confirm]
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
    @order.status = 'waiting_for_buffet_review'
    
    if params[:commit] == "Dentro do Buffet" || params[:commit] == "Em outro endereço"
      @order.update(order_params)
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
    if current_user.company? 
      @payment_method_availables = PaymentMethod.column_names.reject { |attribute| ['id', 'created_at', 'updated_at'].include? attribute}
      @orders_approved_this_date = @buffet_registration.orders.approved.where("date = :date AND id != :id", {date: @order.date, id: @order.id})
      @orders_waiting_for_client_review = @buffet_registration.orders.waiting_for_client_review.where("date = :date AND id != :id", {date: @order.date, id: @order.id})
      @orders_waiting_for_buffet_review = @buffet_registration.orders.waiting_for_buffet_review.where("date = :date AND id != :id", {date: @order.date, id: @order.id})
    end
  end

  def cancel 
    @order.canceled!
    redirect_to @order
  end

  def set_final_value
    @event_type = @order.event_type
    @buffet_registration = @event_type.buffet_registration
    @orders_approved_this_date = @buffet_registration.orders.approved.where("date = :date AND id != :id", {date: @order.date, id: @order.id})
    @orders_waiting_for_client_review = @buffet_registration.orders.waiting_for_client_review.where("date = :date AND id != :id", {date: @order.date, id: @order.id})
    @orders_waiting_for_buffet_review = @buffet_registration.orders.waiting_for_buffet_review.where("date = :date AND id != :id", {date: @order.date, id: @order.id})
    @payment_method_availables = PaymentMethod.column_names.reject { |attribute| ['id', 'created_at', 'updated_at'].include? attribute}

    if params[:commit] == "Editar Valor Final"
      @order.status = 'waiting_for_buffet_review'
      return render 'show'
    end

    @order.status = 'waiting_for_client_review'
    if @order.update(params.require(:order).permit(:final_value, :justification_final_value, :expiration_date, :payment_method))
      redirect_to @order, alert: "Adicionado valor final com sucesso"
    else 
      @order.status = 'waiting_for_buffet_review'
      flash.now.notice = @order.errors.full_messages
      render 'show'
    end
  end
  
  def confirm
    @order.status= 'approved'
    if @order.valid?
      @order.save
      redirect_to @order, alert: "Pedido Confirmado"
    else
      flash.notice = @order.errors.full_messages
      @order.canceled!
      redirect_to @order
    end
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