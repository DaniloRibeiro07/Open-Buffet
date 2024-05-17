class EvaluationsController < ApplicationController
  def create
    @order = Order.find(params[:order_id])
    evaluation_params = params.require(:evaluation).permit(:score, :comment)
    @order.build_evaluation(evaluation_params)
    if @order.evaluation.save 
      redirect_to @order, alert: "Comentário adicionado com sucesso"
    else
      redirect_to @order, notice: @order.evaluation.errors.full_messages 
    end
  end
end