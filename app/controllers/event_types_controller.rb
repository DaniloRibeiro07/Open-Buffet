class EventTypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy, :delete_image]
  before_action :set_event_type_and_buffet_registration, only: [:show, :edit, :update, :destroy]
  before_action :acess_by_owner, only: [:edit, :update, :destroy]

  def new
    @event_type = EventType.new
    @buffet_registration = BuffetRegistration.find_by(user_id: current_user.id) 
  end

  def create 
    @event_type = EventType.new(params_event_type)
    @event_type.user = current_user 
    @buffet_registration = BuffetRegistration.find_by(user_id: current_user.id) 
    @event_type.buffet_registration = @buffet_registration
    
    if @event_type.valid? 
      @event_type.images.attach(params[:event_type][:images])
      @event_type.save
      redirect_to @event_type, notice: "Evento Cadastrado com Sucesso"
    else
      flash.now.notice = @event_type.errors.full_messages
      render "new"
    end
    
  end

  def show;end

  def edit;end

  def update 
    if @event_type.update(params_event_type)
      @event_type.images.attach(params[:event_type][:images])
      action = params[:commit]
      if action != "Salvar"
        delete_image_index = action.split('-')[1].to_i - 1
        @event_type.images[delete_image_index].purge
        redirect_to  edit_event_type_path(@event_type)
      else
        redirect_to @event_type, notice: "Evento Atualizado com Sucesso"
      end
    else
      action = params[:commit]
      if action != "Salvar"
        delete_image_index = action.split('-')[1].to_i - 1
        @event_type.images[delete_image_index].purge
        set_event_type_and_buffet_registration
        @event_type.update(params_event_type)
        render 'edit'
      else
        flash.now.notice = @event_type.errors.full_messages
        render "edit"
      end
    end
  end

  def destroy 
    @event_type.destroy
    redirect_to @event_type.buffet_registration, notice: "Evento Deletado com Sucesso"
  end

  def delete_image
    if(current_user != EventType.find(params[:id]))
      ActiveStorage::Attachment.find(params[:image_id]).purge
      render plain: "sucesso", status: 200
    else
      render plain: "falha", status: 503
    end
  end

  private 

  def set_event_type_and_buffet_registration
    @event_type = EventType.find(params[:id])
    @buffet_registration = @event_type.buffet_registration
  end

  def params_event_type 
    params.require(:event_type).permit(:name, :description, :minimum_quantity, :maximum_quantity,
    :duration, :menu, :alcoholic_beverages, :decoration, :valet, :insider, :outsider, :different_weekend, 
    working_day_price_attributes: [:base_price, :price_per_person, :overtime_rate], 
    weekend_price_attributes: [:base_price, :price_per_person, :overtime_rate])
  end

  def acess_by_owner
    @event_type = EventType.find(params[:id])
    if current_user != @event_type.user 
      redirect_to root_path, notice: "Está página não existe"
    end
  end

end