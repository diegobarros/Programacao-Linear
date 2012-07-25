class CoeficienteRestricao < ActiveRecord::Base
  belongs_to :restricao
  attr_accessible :valor
end
