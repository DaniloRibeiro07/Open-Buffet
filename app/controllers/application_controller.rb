class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :create_buffet_for_company
  
  protected
  
  def create_buffet_for_company 
    if user_signed_in? && current_user.company && request.path != destroy_user_session_path && request.method == "GET" 
      if !BuffetRegistration.find_by(user_id: current_user.id) && request.path != new_buffet_registration_path
        redirect_to new_buffet_registration_path, notice: "Preencha os dados do seu Buffet"
      end
    end
  end
  
  def configure_permitted_parameters
    if params[:user] && params[:user][:company] == 'true'
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :last_name, :company])    
    else
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :last_name, :company, client_datum_attributes:[:cpf]])    
    end
  end
end
