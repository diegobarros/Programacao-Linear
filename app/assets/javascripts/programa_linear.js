/*
 * author Diego Augusto
 */





$(document).ready(function(){
	
	var idPagina = document.URL.substring(document.URL.length, document.URL.lastIndexOf('/') + 1);
	
	if (idPagina != 'visualizar_exemplo.1') {
		atualiza_indice();
	};
	
});


/* Atualiza os índices das variáveis */
function atualiza_indice () {
	
    var i = 1;
	var numeroVariaveis = $('ul:first-child li  i').length;

	$("li").children('sub').each(function(){
		if (i > numeroVariaveis) {
			i = 1;
			$(this).html(i)
			i++;
		} else {
			
			$(this).html(i)
			i++;
		};

	});
	
	
} 
