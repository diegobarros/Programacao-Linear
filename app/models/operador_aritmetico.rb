class OperadorAritmetico < ActiveRecord::Base
  attr_accessible :nome, :simbolo
  
  has_many :operador_aritmetico_funcao_objetivos
  has_many :funcao_objetivos, :through => :operador_aritmetico_funcao_objetivos
  
  has_many :operador_aritmetico_restricoes
  has_many :restricoes, :through => :operador_aritmetico_restricoes
end
