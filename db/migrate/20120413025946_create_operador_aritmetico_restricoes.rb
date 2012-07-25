class CreateOperadorAritmeticoRestricoes < ActiveRecord::Migration
  def change
    create_table :operador_aritmetico_restricoes do |t|
      t.integer :operador_aritmetico_id
      t.integer :restricao_id
      t.integer :posicao

      t.timestamps
    end
  end
end
