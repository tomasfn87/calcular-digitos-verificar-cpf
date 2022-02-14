type numero = number | string | object;
type string_numerica = string;

const limpar_numero = (numero:numero):string_numerica => {
/* "limpar_numero" aceita 3 tipos de dados: números, strings ou
objetos iteráveis do tipo array, e retorna uma string contendo apenas
caracteres numéricos (de 0 a 9, ou um inteiro convertido em string).
    Primeiramente, é necessário obter uma string intermediária, 
portanto, caso receba um array, a função irá iterar na primeira
camada de itens, e, caso sejam do tipo number ou string, serão, se
forem números, covertidos para string, e então concatenados a uma
variável. Caso "limpar_numero" receba um número, o mesmo será
convertido em string.
    Uma vez obtida uma string a partir do argumento recebido, os
caracteres da mesma serão checados se são números de 0 a 9: em caso
positivo, serão concatenados a uma variável, que será retornada ao
final da execução.
*/
  let numero_em_limpeza:string = "";
  let numero_limpo:string_numerica = "";

  if (typeof numero === 'object' 
    && Array.isArray(numero) 
    && numero.length !== 0) {
    for (let i of numero) {
      if (typeof i === 'string') {
        numero_em_limpeza += i;
      } else if (typeof i === 'number') {
        numero_em_limpeza += i.toString();
      };
    };
  } else if (typeof numero === 'number') {
    numero_em_limpeza = numero.toString();
  } else if (typeof numero === 'string') {
    if (numero.length === 0) {
      return numero_limpo;
    };
    numero_em_limpeza = numero;
  };

  for (let c of numero_em_limpeza) {
    if (c.charCodeAt(0) >= 48 && c.charCodeAt(0) <= 57) {
      numero_limpo += c;
    };
  };

  return numero_limpo;
}

export default limpar_numero;
