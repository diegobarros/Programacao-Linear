class Restricao < ActiveRecord::Base
  attr_accessible :constante, :coeficiente_restricoes_attributes, :operador_aritmetico_restricoes_attributes,  :operador_sentencial_id, :OperadorSentencial_attributes
  
  belongs_to :programalinear
  belongs_to :OperadorSentencial
  
  has_many :coeficiente_restricoes
  
  has_many :operador_aritmetico_restricoes
  has_many :operador_aritmeticos, :through => :operador_aritmetico_restricoes
  
  accepts_nested_attributes_for :coeficiente_restricoes
  accepts_nested_attributes_for :operador_aritmetico_restricoes

end
