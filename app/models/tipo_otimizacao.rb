class TipoOtimizacao < ActiveRecord::Base
  attr_accessible :nome, :funcao_objetivos_attributes
  has_many :funcao_objetivos
  
  accepts_nested_attributes_for :funcao_objetivos
  
end
