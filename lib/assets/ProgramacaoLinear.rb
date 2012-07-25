# coding: utf-8
require 'bigdecimal'
require 'bigdecimal/util'

class ProgramacaoLinear
  
  private 
  @coeficientesDaFuncaoObjetivo
  private 
  @coeficientesDasRestricoes
  private 
  @numeroDeCoeficientes
  private 
  @numeroDeRestricoes
  private 
  @programaLinearAuxiliar
  private 
  @termosConstantesDasRestricoes
  private 
  @variaveisBasicas
  
  # Constante que designa pequenas quantidades, ou quantidades que tendem a zero, em particular no estudo dos limites ou da continuidade 
  
  #EPSILON = 1.0E-1
  #EPSILON = Float::EPSILON
  
  attr_accessor :coeficientesDaFuncaoObjetivo
  attr_accessor :coeficientesDasRestricoes
  attr_accessor :termosConstantesDasRestricoes
  attr_accessor :numeroDeCoeficientes
  attr_accessor :numeroDeRestricoes
  attr_accessor :variaveisBasicas
  
  
  def initialize(coeficientesRestricoes, termosConstantesRestricoes, coeficientesFuncaoObjetivo)
    @coeficientesDasRestricoes = coeficientesRestricoes
    @termosConstantesDasRestricoes = termosConstantesRestricoes
    @coeficientesDaFuncaoObjetivo = coeficientesFuncaoObjetivo
    
    @numeroDeRestricoes = termosConstantesRestricoes.length
    @numeroDeCoeficientes = coeficientesFuncaoObjetivo.length
    
    @programaLinearAuxiliar = Array.new(@numeroDeRestricoes + 1){ Array.new(@numeroDeCoeficientes + @numeroDeRestricoes + 1){ Float("0") }}
      
    InicializaSimplex()
    
  end
  
  
  # Configura o programa linear para ser solucionado pelo Simplex
  private
  def InicializaSimplex
    
    for i in 0..@numeroDeRestricoes-1
      for j in 0..@numeroDeCoeficientes-1
        @programaLinearAuxiliar[i][j] = @coeficientesDasRestricoes[i][j]
      end
    end
    
    for i in 0..@numeroDeRestricoes-1
      @programaLinearAuxiliar[i][@numeroDeCoeficientes + i] = Float("1")
    end
    
    for j in 0..@numeroDeCoeficientes-1
      @programaLinearAuxiliar[@numeroDeRestricoes][j] = coeficientesDaFuncaoObjetivo[j]
    end
    
    
    for i in 0..@numeroDeRestricoes-1
      @programaLinearAuxiliar[i][@numeroDeRestricoes + @numeroDeCoeficientes] = termosConstantesDasRestricoes[i]
    end
    
    @variaveisBasicas = Array.new(@numeroDeRestricoes)
    
    for i in 0..@numeroDeRestricoes-1
      @variaveisBasicas[i] = @numeroDeCoeficientes + i
    end
  end
  
  
  # Menor índice de uma coluna não-básica com um custo positivo
  private
  def MenorIndiceColunaNaoBasica
    for j in 0..(@numeroDeRestricoes + @numeroDeCoeficientes)-1
      if @programaLinearAuxiliar[@numeroDeRestricoes][j] > 0 then
        return j
      end
    end
    return -1
  end
  
  
# Menor índice de uma coluna não básica com maior custo positivo
  private
  def IndiceColunaNaoBasica
    coluna = 0
    
    for j in 1..(@numeroDeRestricoes + @numeroDeCoeficientes)-1
      
      if @programaLinearAuxiliar[@numeroDeRestricoes][j] > @programaLinearAuxiliar[@numeroDeRestricoes][coluna] then
        coluna = j
      end
  
    end
    
    return @programaLinearAuxiliar[@numeroDeRestricoes][coluna] <= 0 ? -1 : coluna
      
  end
  
  # Encontra a linha utilizando a regra de menor taxa. Retorna -1 caso não encontre tal linha.
  private
  def MenorTaxaAjuste(coluna)
    linha = -1
    for i in 0..@numeroDeRestricoes-1
      if @programaLinearAuxiliar[i][coluna] > 0 then
        
        if linha == -1 then
          linha = i
        elsif (@programaLinearAuxiliar[i][@numeroDeRestricoes + @numeroDeCoeficientes] / @programaLinearAuxiliar[i][coluna]) < (@programaLinearAuxiliar[linha][@numeroDeRestricoes + @numeroDeCoeficientes] / @programaLinearAuxiliar[linha][coluna]) then
          linha = i
        end
        
      end
    
    end
    
    return linha 
    
  end
    

  # Escolhe o elemento pivot com a entrada (linha, coluna) utilizando a eliminação Gauss-Jordan
  private
  def Pivot(linha, coluna)
    
    for i in 0..@numeroDeRestricoes
      for j in 0..(@numeroDeRestricoes + @numeroDeCoeficientes)
        if i != linha && j != coluna then
          @programaLinearAuxiliar[i][j] -= @programaLinearAuxiliar[linha][j] * @programaLinearAuxiliar[i][coluna] / @programaLinearAuxiliar[linha][coluna]   
        end
        
      end
    end
    
    # Zera Coluna
    for i in 0..@numeroDeRestricoes
      if i != linha
        @programaLinearAuxiliar[i][coluna] = Float("0")
      end
    end
    
    # Escalona linha
    for j in 0..(@numeroDeRestricoes + @numeroDeCoeficientes)
      if j != coluna
        @programaLinearAuxiliar[linha][j] /= @programaLinearAuxiliar[linha][coluna]
      end      
    end
    
    @programaLinearAuxiliar[linha][coluna] = Float("1")
    
  end
  
  
# Retorna o valor objetivo ótimo
  public
  def ValorObjetivoOtimo
    return -@programaLinearAuxiliar[@numeroDeRestricoes][@numeroDeRestricoes + @numeroDeCoeficientes]
  end
  
  # Retorna o vetor com a solução primal
  public
  def SolucaoPrimal
    
    solucaoPrimal = Array.new(@numeroDeCoeficientes)
    
    for i in 0..@numeroDeRestricoes-1
      if @variaveisBasicas[i] < @numeroDeCoeficientes then
        solucaoPrimal[@variaveisBasicas[i]] = @programaLinearAuxiliar[i][@numeroDeRestricoes + @numeroDeCoeficientes]  
      end
    end
    return solucaoPrimal
  end

# Verifica se a solução primal é possível
private
def SolucaoPrimalPossivel
  
  solucaoPrimal = SolucaoPrimal()
  
  # Verifica se a solução primal é maior ou igual a zero
  for j in 0..solucaoPrimal.length-1
    
    if solucaoPrimal[j] < 0.0 then
      return false
    end
    
  end
  
  # Verifica se os coeficientes das restrições são menores ou iguais aos termos constantes das restrições
  for i in 0..@numeroDeRestricoes-1
    
    soma = Float("0")
    
    for j in 0..@numeroDeCoeficientes-1
      soma += @programaLinearAuxiliar[i][j] * solucaoPrimal[j]
    end
    
    if soma > @termosConstantesDasRestricoes[i] + EPSILON then
      return false
    end

  end
  
  return true
  
end
  
  
  
  # Retorna o vetor com a solução dual
  public
  def SolucaoDual
    
    solucaoDual = Array.new(@numeroDeRestricoes)
    
    for i in 0..@numeroDeRestricoes-1
      solucaoDual[i] = -@programaLinearAuxiliar[@numeroDeRestricoes][@numeroDeCoeficientes + i]
    end
    
    return solucaoDual

  end
  
  # Verifica se a solução dual é possível
  private
  def SolucaoDualPossivel
    
    solucaoDual = SolucaoDual()
    
    # Verifica se a solução dual é maior ou igual a zero
    for i in 0..solucaoDual.length-1
      if solucaoDual[i] < 0.0 then
        return false
      end
    end
    
    # Verifica se os coeficientes de restrição são maiores ou iguais aos coeficientes da função obejetivo
    for j in 0..@numeroDeCoeficientes-1
      
      soma = Float("0")
      
      for i in 0..@numeroDeRestricoes-1
        soma += @coeficientesDasRestricoes[i][j] * solucaoDual[i]
      end
      
      if soma < @coeficientesDaFuncaoObjetivo[j] - EPSILON then
        return false
      end
      
    end
    
    return true
    
  end

  # Verifica se a solução é ótima
  private
  def SolucaoOtima
    
    solucaoPrimal = SolucaoPrimal()
    solucaoDual = SolucaoDual()
    valor = ValorObjetivoOtimo()
    valor1 = Float("0")
    valor2 = Float("0")
    
    for j in 0..solucaoPrimal.length-1
      valor1 += @coeficientesDaFuncaoObjetivo[j] * solucaoPrimal[j]
    end
    
    for i in 0..solucaoDual.length-1
      valor2 += solucaoDual[i] * @termosConstantesDasRestricoes[i]
    end
    
    if (valor - valor1).abs > EPSILON || (valor - valor2).abs > EPSILON then
      return false
    end
    
    return true
    
  end
  
  # Roda o algoritmo Simplex começando do BFS inicial
  public 
  def SolucionaProblema
    
    coluna = MenorIndiceColunaNaoBasica()
    
    while coluna != -1
      
      linha = MenorTaxaAjuste(coluna)
     
      raise TypeError, 'Programa Linear Ilimitado' if linha == -1
      
      Pivot(linha, coluna)
      
      @variaveisBasicas[linha] = coluna
      
      coluna = MenorIndiceColunaNaoBasica()
      
    end
    
  end
  
 
  
  # Verifica se a solução é ótima
  private
  def VerificaResultado
    return SolucaoPrimalPossivel() && SolucaoDualPossivel() && SolucaoOtima()
  end
  
  
  public
  def Imprime
    
    puts "\n\n\n\tNúmero de Restrições = " + @numeroDeRestricoes.to_s + "\n\tNúmero de Coeficientes = " + @numeroDeRestricoes.to_s
    puts "\n\n\n"
    
    for i in 0..@numeroDeRestricoes
       for j in 0..@numeroDeCoeficientes + @numeroDeRestricoes
            print "\t" + @programaLinearAuxiliar[i][j].to_s
       end
          puts
    end

      for i in 0..@numeroDeRestricoes-1
        
        if @variaveisBasicas[i] < @numeroDeCoeficientes then
          
          print "\n\n\nX_" + @variaveisBasicas[i].to_s + " = " + @programaLinearAuxiliar[i][@numeroDeRestricoes + @numeroDeCoeficientes].to_s
        
        end      
        puts
      end
      
      
      puts "Valor = " + ValorObjetivoOtimo().to_s
    
  end
  
  
  
end
