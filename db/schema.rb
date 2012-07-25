# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120413150217) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "coeficiente_funcao_objetivos", :force => true do |t|
    t.integer  "funcao_objetivo_id"
    t.float    "valor",              :null => false
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "coeficiente_funcao_objetivos", ["funcao_objetivo_id"], :name => "index_coeficiente_funcao_objetivos_on_funcao_objetivo_id"

  create_table "coeficiente_restricoes", :force => true do |t|
    t.integer  "restricao_id"
    t.float    "valor",        :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "coeficiente_restricoes", ["restricao_id"], :name => "index_coeficiente_restricoes_on_restricao_id"

  create_table "funcao_objetivos", :force => true do |t|
    t.integer  "tipo_otimizacao_id"
    t.integer  "programa_linear_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "funcao_objetivos", ["programa_linear_id"], :name => "index_funcao_objetivos_on_programa_linear_id"
  add_index "funcao_objetivos", ["tipo_otimizacao_id"], :name => "index_funcao_objetivos_on_tipo_otimizacao_id"

  create_table "operador_aritmetico_funcao_objetivos", :force => true do |t|
    t.integer  "operador_aritmetico_id"
    t.integer  "funcao_objetivo_id"
    t.integer  "posicao"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "operador_aritmetico_restricoes", :force => true do |t|
    t.integer  "operador_aritmetico_id"
    t.integer  "restricao_id"
    t.integer  "posicao"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "operador_aritmeticos", :force => true do |t|
    t.string   "nome",       :limit => 45, :null => false
    t.string   "simbolo",    :limit => 1,  :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "operador_sentenciais", :force => true do |t|
    t.string   "nome",       :null => false
    t.string   "simbolo",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "programa_lineares", :force => true do |t|
    t.string   "nome"
    t.text     "descricao"
    t.integer  "numero_variavel"
    t.integer  "numero_restricao"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "restricoes", :force => true do |t|
    t.integer  "programa_linear_id"
    t.integer  "operador_sentencial_id"
    t.float    "constante",              :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "restricoes", ["operador_sentencial_id"], :name => "index_restricoes_on_operador_sentencial_id"
  add_index "restricoes", ["programa_linear_id"], :name => "index_restricoes_on_programa_linear_id"

  create_table "tipo_otimizacoes", :force => true do |t|
    t.string   "nome",       :limit => 9, :null => false
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

end
