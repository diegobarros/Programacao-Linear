class OperadorSentencial < ActiveRecord::Base
  attr_accessible :nome, :simbolo
  has_many :restricoes
  accepts_nested_attributes_for :restricoes
end
