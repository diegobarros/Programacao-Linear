class ProgramaLinearController < ApplicationController
  
  include Simplex
  
  def index
 
    
  end
  
  def novo
    
    @programa_linear = ProgramaLinear.new
    @programa_linear.numero_variavel = params[:numero_variaveis]
    @programa_linear.numero_restricao = params[:numero_restricoes]
      
    @programa_linear.funcao_objetivo = FuncaoObjetivo.new 
    @programa_linear.numero_variavel.times { @programa_linear.funcao_objetivo.coeficiente_funcao_objetivo.build }
    @programa_linear.numero_variavel.times { @programa_linear.funcao_objetivo.operador_aritmetico_funcao_objetivos.build }
       
         
    @programa_linear.numero_restricao.times do
      restricao =  @programa_linear.restricoes.build
      @programa_linear.numero_variavel.times { restricao.coeficiente_restricoes.build }
        
    end

    respond_to do |format|
      format.html 
      format.json { render json: @programa_linear  }
    end
    
  end
  
  

  def exibir_resultado
    respond_to do |formato|
         formato.html { render html:  @programacao_linear }
         formato.json { render json:  @programacao_linear }
       end
    
   
  end

  def solucionar_problema
    
    @programa_linear = ProgramaLinear.new(params[:programa_linear])
      
    @programa_linear.numero_variavel =  @programa_linear.funcao_objetivo.coeficiente_funcao_objetivo.length
    @programa_linear.numero_restricao = @programa_linear.restricoes.length
    
    @coeficiente_objetivo = Array.new()
    @constante_restricao = Array.new()
    @coeficientes_restricoes = Array.new(@programa_linear.numero_restricao) { Array.new(@programa_linear.numero_variavel) }
      
    @programa_linear.funcao_objetivo.coeficiente_funcao_objetivo.each do | coeficiente |     
      if @programa_linear.funcao_objetivo.tipo_otimizacao_id == 1 then
      
        @coeficiente_objetivo.push(coeficiente.valor)
      else
        @coeficiente_objetivo.push((coeficiente.valor * -1))
      end
    end
    
    @programa_linear.restricoes.each do | coeficiente |
      @constante_restricao.push(coeficiente.constante)
    end
    
          
    for i in 0..@programa_linear.numero_restricao-1
      for j in 0..@programa_linear.numero_variavel-1      
        @coeficientes_restricoes[i][j] = @programa_linear.restricoes[i].coeficiente_restricoes[j].valor
      end
    end
  
    @programacao_linear = ProgramacaoLinear.new(@coeficientes_restricoes, @constante_restricao, @coeficiente_objetivo)
    @programacao_linear.SolucionaProblema
    
    session[:programacao_linear] = @programacao_linear
      
    redirect_to :controller => 'programa_linear', :action => 'exibir_resultado', :d => @programacao_linear
  end

  def abrir_exemplo
    @programa_linear = ProgramaLinear.all
    
    respond_to do |format|
       format.html
       format.json { render json: @programa_linear }
    end
    
  end

  def visualizar_exemplo
    @programa_linear = ProgramaLinear.find(params[:format])
    #render :text => @programa_linear.restricoes.inspect
  end
  
  
  def solucionar_exemplo
    @programa_linear = ProgramaLinear.find(params[:id])
    
    @programa_linear.numero_variavel =  @programa_linear.funcao_objetivo.coeficiente_funcao_objetivo.length
       @programa_linear.numero_restricao = @programa_linear.restricoes.length
       
       @coeficiente_objetivo = Array.new()
       @constante_restricao = Array.new()
       @coeficientes_restricoes = Array.new(@programa_linear.numero_restricao) { Array.new(@programa_linear.numero_variavel) }
         
       @programa_linear.funcao_objetivo.coeficiente_funcao_objetivo.each do | coeficiente |     
         if @programa_linear.funcao_objetivo.tipo_otimizacao_id == 1 then
         
           @coeficiente_objetivo.push(coeficiente.valor)
         else
           @coeficiente_objetivo.push((coeficiente.valor * -1))
         end
       end
       
       @programa_linear.restricoes.each do | coeficiente |
         @constante_restricao.push(coeficiente.constante)
       end
       
             
       for i in 0..@programa_linear.numero_restricao-1
         for j in 0..@programa_linear.numero_variavel-1      
           @coeficientes_restricoes[i][j] = @programa_linear.restricoes[i].coeficiente_restricoes[j].valor
         end
       end
     
       @programacao_linear = ProgramacaoLinear.new(@coeficientes_restricoes, @constante_restricao, @coeficiente_objetivo)
       @programacao_linear.SolucionaProblema
       
       session[:programacao_linear] = @programacao_linear
         
       redirect_to :controller => 'programa_linear', :action => 'exibir_resultado', :d => @programacao_linear   
  end
  
  
  
  
  
  
  
  
  
  
  
end
