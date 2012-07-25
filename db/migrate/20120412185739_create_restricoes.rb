class CreateRestricoes < ActiveRecord::Migration
  def change
    create_table :restricoes do |t|
      t.references :programa_linear
      t.references :operador_sentencial
      t.float :constante, :null => false

      t.timestamps
    end
    add_index :restricoes, :programa_linear_id
    add_index :restricoes, :operador_sentencial_id
  end
end
