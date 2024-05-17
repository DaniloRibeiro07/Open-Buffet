class BuffetRegistrationsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :create]
  before_action :set_buffet_registration_and_payment_method, only: [:edit, :update, :show]
  before_action :acess_by_owner, only: [:edit, :update]
  before_action :redirect_user_client_and_user_with_buffet, only: [:new, :create]

  def new
    @buffet_registration = BuffetRegistration.new
    @payment_method_availables = PaymentMethod.column_names.reject { |attribute| ['id', 'created_at', 'updated_at'].include? attribute}
  end

  def create
    @buffet_registration = BuffetRegistration.new(params_buffet_registration_and_payment_method)
    @buffet_registration.user = current_user
    if @buffet_registration.valid?  
      @buffet_registration.save
      redirect_to root_path, notice: "Buffet Cadastrado com Sucesso"
    else
      flash.now.notice = @buffet_registration.errors.full_messages
      @payment_method_availables = PaymentMethod.column_names.reject { |attribute| ['id', 'created_at', 'updated_at'].include? attribute}
      render 'new'
    end
  end

  def show;end

  def edit;end

  def update 
    if @buffet_registration.update(params_buffet_registration_and_payment_method)
      redirect_to @buffet_registration, notice: "Buffet Atualizado com Sucesso"
    else
      flash.now.notice = @buffet_registration.errors.full_messages
      render 'edit'
    end
  end

  def search
    search  = "%#{params[:search]}%"
    @buffet_records = BuffetRegistration.left_outer_joins(:event_types)
      .where("(name LIKE ? AND status = 1) OR trading_name LIKE ? OR city LIKE ?", search, search, search).distinct.order(trading_name: :asc)
  end

  def desactive
    @buffet_registration = BuffetRegistration.find(params[:id])
    @buffet_registration.desactive!
    redirect_to @buffet_registration, alert: "Buffet Desativado com sucesso"
  end

  def active
    @buffet_registration = BuffetRegistration.find(params[:id])
    @buffet_registration.active!
    redirect_to @buffet_registration, alert: "Buffet Ativado com sucesso"
  end

  private

  def redirect_user_client_and_user_with_buffet
    return redirect_to root_path, notice: "Está página não existe" unless current_user.company
    return redirect_to root_path if BuffetRegistration.find_by(user_id: current_user.id)
  end

  def acess_by_owner
    @buffet_registration = BuffetRegistration.find(params[:id])
    if current_user != @buffet_registration.user 
      redirect_to root_path, notice: "Está página não existe"
    end
  end

  def set_buffet_registration_and_payment_method 
    @buffet_registration = BuffetRegistration.find(params[:id])
    @payment_method = @buffet_registration.payment_method
    if current_user == @buffet_registration.user 
      @event_types =  @buffet_registration.event_types
    else
      @event_types =  @buffet_registration.event_types.active
    end
    @payment_method_availables = PaymentMethod.column_names.reject { |attribute| ['id', 'created_at', 'updated_at'].include? attribute}
  end

  def params_buffet_registration_and_payment_method 
    payment_method_availables = PaymentMethod.column_names.reject{ |attribute| ['id', 'created_at', 'updated_at'].include?(attribute)}.map(&:to_sym)
    params.require(:buffet_registration).permit(:trading_name, :company_name, :cnpj, :phone, :email, :public_place, 
      :neighborhood, :state, :city, :zip, :complement, :address_number, :description,  payment_method_attributes: [payment_method_availables])
  end

end