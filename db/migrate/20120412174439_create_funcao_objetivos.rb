class CreateFuncaoObjetivos < ActiveRecord::Migration
  def change
    create_table :funcao_objetivos do |t|
      t.references :tipo_otimizacao
      t.references :programa_linear
      t.timestamps
    end
    add_index :funcao_objetivos, :tipo_otimizacao_id
    add_index :funcao_objetivos, :programa_linear_id
  end
end
