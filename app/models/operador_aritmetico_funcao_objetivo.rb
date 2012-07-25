class OperadorAritmeticoFuncaoObjetivo < ActiveRecord::Base
  attr_accessible :FuncaoObjetivo_id, :OperadorAritmetico_id, :posicao
  
  belongs_to :FuncaoObjetivo
  belongs_to :OperadorAritmetico
  
end
