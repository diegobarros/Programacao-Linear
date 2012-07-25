class CreateOperadorAritmeticos < ActiveRecord::Migration
  def change
    create_table :operador_aritmeticos do |t|
      t.string :nome, :limit => 45, :null => false
      t.string :simbolo, :limit => 1, :null => false

      t.timestamps
    end
  end
end
