class CreateOperadorAritmeticoFuncaoObjetivos < ActiveRecord::Migration
  def change
    create_table :operador_aritmetico_funcao_objetivos do |t|
      t.integer :operador_aritmetico_id
      t.integer :funcao_objetivo_id
      t.integer :posicao

      t.timestamps
    end
  end
end
