class CoeficienteFuncaoObjetivo < ActiveRecord::Base
  belongs_to :funcaoobjetivo
  attr_accessible :valor
end
