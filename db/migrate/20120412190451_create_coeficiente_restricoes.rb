class CreateCoeficienteRestricoes < ActiveRecord::Migration
  def change
    create_table :coeficiente_restricoes do |t|
      t.references :restricao
      t.float :valor, :null => false

      t.timestamps
    end
    add_index :coeficiente_restricoes, :restricao_id
  end
end
