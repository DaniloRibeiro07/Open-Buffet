class ClientDatum < ApplicationRecord
  belongs_to :user
  validates :cpf, presence: true
  validates :cpf, length: { is: 11 }
  validate :cpf_valid?
  validates :cpf, uniqueness: true

  protected

  def cpf_valid?
    
    banned_cpfs = %w[00000000000
                    11111111111
                    22222222222
                    33333333333
                    44444444444
                    55555555555
                    66666666666
                    77777777777
                    88888888888
                    99999999999
                    12345678909
                    01234567890]
    def check_cpf
      cpf = self.cpf

      digit_1 = cpf[-2].to_i
      digit_2 = cpf[-1].to_i
      
      checker_1 = 0
      
      cpf[0..8].chars.each_with_index do |number, index|
        checker_1 += number.to_i*(10 - index)
      end
      
      checker_1 *= 10
      checker_1 %= 11
      
      return false if checker_1  != digit_1
      
      checker_2 = 0
      
      cpf[0..9].chars.each_with_index do |number, index|
        checker_2 += number.to_i*(11-index)
      end
      
      checker_2 *= 10
      checker_2 %= 11
      
      return false if checker_2  != digit_2

      true
    end

    if banned_cpfs.include?(self.cpf) || !check_cpf
      self.errors.add :cpf , "inválido"
    end
  end
end
