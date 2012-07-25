class CreateTipoOtimizacoes < ActiveRecord::Migration
  def change
    create_table :tipo_otimizacoes do |t|
      t.string :nome, :limit => 9, :null => false

      t.timestamps
    end
  end
end
