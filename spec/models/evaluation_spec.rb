require 'rails_helper'

RSpec.describe Evaluation, type: :model do
  describe "#valid" do 
    it 'nota é obrigatório' do 
      evaluation = Evaluation.new()
      evaluation.valid?
      result = evaluation.errors.full_messages.include?"Nota não pode ficar em branco"
      expect(result).to eq true  
    end

    it 'nota deve ser menor ou igual a 5' do 
      evaluation = Evaluation.new(score: 6)
      evaluation.valid?
      result = evaluation.errors.full_messages.include?"Nota deve ser menor ou igual a 5"
      expect(result).to eq true  
    end

    it 'nota deve ser maior ou igual a 0' do 
      evaluation = Evaluation.new(score: -1)
      evaluation.valid?
      result = evaluation.errors.full_messages.include?"Nota deve ser maior ou igual a 0"
      expect(result).to eq true  
    end

  end
end
