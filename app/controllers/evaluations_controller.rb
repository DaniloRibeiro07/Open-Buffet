class EvaluationsController < ApplicationController
  def create
    @order = Order.find(params[:order_id])
    evaluation_params = params.require(:evaluation).permit(:score, :comment)
    @order.build_evaluation(evaluation_params)
    if @order.evaluation.save 
      @order.evaluation.images.attach(params[:evaluation][:images])
      redirect_to @order, alert: "Comentário adicionado com sucesso"
    else
      redirect_to @order, notice: @order.evaluation.errors.full_messages 
    end
  end

  def index
    @buffet_registration = BuffetRegistration.find(params[:buffet_registration_id])
    @evaluations = @buffet_registration.evaluations.order(created_at: :desc)
  end
end