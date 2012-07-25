class CreateCoeficienteFuncaoObjetivos < ActiveRecord::Migration
  def change
    create_table :coeficiente_funcao_objetivos do |t|
      t.references :funcao_objetivo
      t.float :valor, :null => false

      t.timestamps
    end
    add_index :coeficiente_funcao_objetivos, :funcao_objetivo_id
  end
end
