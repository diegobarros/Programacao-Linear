class CreateProgramaLineares < ActiveRecord::Migration
  def change
    create_table :programa_lineares do |t|
      t.string :nome
      t.text :descricao
      t.integer :numero_variavel
      t.integer :numero_restricao
      t.timestamps
    end
  end
end
