class EventTypesController < ApplicationController
  before_action :set_event_type_and_buffet_registration, only: [:show, :edit, :update, :destroy]

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
      redirect_to @event_type, notice: "Evento Atualizado com Sucesso"
    else
      flash.now.notice = @event_type.errors.full_messages
      render "edit"
    end
  end

  def destroy 
    @event_type.destroy
    redirect_to root_path, notice: "Evento Deletado com Sucesso"
  end

  private 

  def set_event_type_and_buffet_registration
    @event_type = EventType.find(params[:id])
    @buffet_registration = @event_type.buffet_registration
  end

  def params_event_type 
    params.require(:event_type).permit(:name, :description, :minimum_quantity, :maximum_quantity,
    :duration, :menu, :alcoholic_beverages, :decoration, :valet, :insider, :outsider)
  end
end