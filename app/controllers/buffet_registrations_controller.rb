class BuffetRegistrationsController < ApplicationController
  before_action :set_buffet_registration_and_payment_method, only: [:edit, :update, :show]
  before_action :acess_by_owner, only: [:edit, :update]

  def new
    if BuffetRegistration.find_by(user_id: current_user.id)
      redirect_to root_path
    else
      @buffet_registration = BuffetRegistration.new
      @payment_method = PaymentMethod.new
    end
  end

  def create
    redirect_to root_path if BuffetRegistration.find_by(user_id: current_user.id)

    payment_method_params, buffet_registration_params = params_buffet_registration_and_payment_method
    @payment_method = PaymentMethod.new(payment_method_params)
    @buffet_registration = BuffetRegistration.new(buffet_registration_params)
    @buffet_registration.payment_method = @payment_method

    @buffet_registration.user = current_user
    if @buffet_registration.valid? &&  @payment_method.valid? 
      @payment_method.save
      @buffet_registration.save
      redirect_to root_path, notice: "Buffet Cadastrado com Sucesso"
    else
      @payment_method.valid?
      messages = @buffet_registration.errors.full_messages
      messages.push(@payment_method.errors.messages[:PaymentMethod][0]) if @payment_method.errors.any?
      flash.now.notice = messages
      render 'new'
    end
  end

  def show;end

  def edit;end

  def update 
    payment_method_params, buffet_registration_params = params_buffet_registration_and_payment_method

    if @buffet_registration.update(buffet_registration_params) && @payment_method.update(payment_method_params)
      @buffet_registration.update(payment_method: @payment_method)
      redirect_to @buffet_registration, notice: "Buffet Atualizado com Sucesso"
    else
      @payment_method.update(payment_method_params)
      messages = @buffet_registration.errors.full_messages
      messages.push(@payment_method.errors.messages[:PaymentMethod][0]) if @payment_method.errors.any?
      flash.now.notice = messages
      render 'edit'
    end
  end

  private

  def acess_by_owner
    @buffet_registration = BuffetRegistration.find(params[:id])
    if current_user != @buffet_registration.user 
      redirect_to root_path, notice: "Está página não existe"
    end
  end

  def set_buffet_registration_and_payment_method 
    @buffet_registration = BuffetRegistration.find(params[:id])
    @payment_method = @buffet_registration.payment_method
    @event_types =  @buffet_registration.event_type
  end

  def params_buffet_registration_and_payment_method 
    buffet_registration_params = params.require(:buffet_registration).permit(:trading_name, :company_name, :cnpj, :phone,
    :email, :public_place, :neighborhood, :state, :city, :zip, :complement, :address_number, :description)

    payment_method_params = params.require(:buffet_registration).permit(PaymentMethod.new.all_available_methods_to_select.map(&:to_sym))

    [payment_method_params, buffet_registration_params]
  end

end