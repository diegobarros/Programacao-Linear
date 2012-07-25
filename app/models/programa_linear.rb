class ProgramaLinear < ActiveRecord::Base
  has_one :funcao_objetivo
  has_many :restricoes
  attr_accessible :descricao, :nome, :numero_variavel, :numero_restricao, :funcao_objetivo_attributes, :restricoes_attributes
  
  accepts_nested_attributes_for :restricoes
  accepts_nested_attributes_for :funcao_objetivo
   
end
