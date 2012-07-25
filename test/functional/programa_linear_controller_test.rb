require 'test_helper'

class ProgramaLinearControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get novo" do
    get :novo
    assert_response :success
  end

  test "should get configurar" do
    get :configurar
    assert_response :success
  end

  test "should get solucionar_problema" do
    get :solucionar_problema
    assert_response :success
  end

  test "should get abrir_exemplo" do
    get :abrir_exemplo
    assert_response :success
  end

  test "should get visualizar_exemplo" do
    get :visualizar_exemplo
    assert_response :success
  end

end
