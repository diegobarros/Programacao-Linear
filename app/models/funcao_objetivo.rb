class FuncaoObjetivo < ActiveRecord::Base
  belongs_to :tipo_otimizacao
  belongs_to :programa_linear
  has_many :coeficiente_funcao_objetivo
  
  
  has_many :operador_aritmetico_funcao_objetivos
  has_many :operador_aritmeticos, :through => :operador_aritmetico_funcao_objetivos
  
  
  accepts_nested_attributes_for :coeficiente_funcao_objetivo
  accepts_nested_attributes_for :operador_aritmetico_funcao_objetivos
  
  attr_accessible :programa_linear_attributes, :coeficiente_funcao_objetivo_attributes, :tipo_otimizacao_id, :operador_aritmetico_funcao_objetivos_attributes
  
  # attr_accessible :title, :body
end
