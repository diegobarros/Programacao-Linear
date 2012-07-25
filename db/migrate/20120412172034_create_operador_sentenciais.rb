class CreateOperadorSentenciais < ActiveRecord::Migration
  def change
    create_table :operador_sentenciais do |t|
      t.string :nome, :null => false
      t.string :simbolo, :null => false

      t.timestamps
    end
  end
end
