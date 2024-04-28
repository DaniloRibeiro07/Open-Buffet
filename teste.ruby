cpf = "07690779514"

verificador1 = cpf[-2].to_i
verificador2 = cpf[-1].to_i

digito1 = 0

cpf[0..8].chars.each_with_index do |number, index|
  digito1+=number.to_i*(10-index)
end

digito1 *= 10
digito1 %= 11

return false if verificador1  != digito1

digito2 = 0

cpf[0..9].chars.each_with_index do |number, index|
  digito2+=number.to_i*(11-index)
end

digito2 *= 10
digito2 %= 11

return false if verificador2  != digito2


puts digito1, digito2