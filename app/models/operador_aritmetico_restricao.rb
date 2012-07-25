class OperadorAritmeticoRestricao < ActiveRecord::Base
  attr_accessible :OperadorAritmetico_id, :Restricao_id, :posicao
  
  belongs_to :OperadorAritmetico
  belongs_to :Restricao
end
