import limpar_numero from "./limpar_numero";

type numero_cpf = number | string | object;
type lista_digitos_cpf = number[];
type digito_verificador_cpf = number;
type digitos_verificadores_cpf = [
  digito_verificador_cpf, digito_verificador_cpf
];

export const obter_lista_digitos = (
  numero_cpf:numero_cpf, info:string='n'
):lista_digitos_cpf => {
/*  A função "obter_lista_digitos" recebe como argumento uma string ou
um número; se o argumento for um número, será transformado em string;
se o tamanho do número for maior que 9, será impressa uma mensagem de
aviso, informado que apenas os 9 primeiros dígitos serão utilizados
para calcular os 2 dígitos verificadores. A função retorna uma lista
cujos elementos são os dígitos do número de CPF recebido.
  O parâmetro "info" tem por valor padrão 'n', e pode receber 'i' ou
'a' (ou 'I' ou 'A'): ambas imprimirão informações adicionais. Nesse
caso, não há diferença entre 'i' e 'a'.
*/
  numero_cpf = limpar_numero(numero_cpf);

  let lista_digitos_cpf:lista_digitos_cpf = [];

  for (let i = 0; i < numero_cpf.length; i++) {
    lista_digitos_cpf.push(parseInt(numero_cpf[i]));
  };

  if (lista_digitos_cpf.length > 9) {
    if (info.toLowerCase() === 'i' || info.toLowerCase() === 'a') {
      let w = "Foi recebido um número de CPF com ";
      w += `${lista_digitos_cpf.length} dígitos: só os 9 primeiros `
      w += "serão utilizados"
      console.warn(w);
    }
    return lista_digitos_cpf.slice(0, 9);
  }

  return lista_digitos_cpf;
};

export const calcular_dv = (
  lista_digitos_cpf:lista_digitos_cpf):digito_verificador_cpf => {
/* A função "calcular_dv" executa o algoritmo de cálculo dos dígitos
verificadores de um número de CPF. */
  let multiplicador:number = lista_digitos_cpf.length + 1;
  let calculo_dv:number[] = [];

  for (let i of lista_digitos_cpf) {
    i *= multiplicador;
    calculo_dv.push(i);
    multiplicador -= 1;
  };

  let dv = 0;

  for (let j of calculo_dv) {
    dv += j;
    dv %= 11;
  }

  if (dv < 2) {
    return 0;
  }

  return 11 - dv;
};

const obter_dvs = (
  Cpf:numero_cpf, info:string='n'
):digitos_verificadores_cpf | [] => {
/* A função "obter_dvs" recebe uma lista de dígitos, e verifica se essa
lista possui ao menos 9 elementos: em caso negativo, imprime uma
mensagem de erro e retorna uma lista vazia; em caso positivo, a função
chamará "calcular_dv" para calcular o primeiro dígito verificador. Uma
vez calculado o primeiro dígito verificador, esse número será incluso
na lista inicial para que o segundo dígito verificador seja calculado. 
A função imprimirá o CPF informado e o CPF completo, ambos marcados no
padrão: XXX.XXX.XXX-DD, onde "X" são os dígitos do CPF e "D" são os
dígitos verificadores. A função retornará uma lista com os dígitos
verificadores.
*/
  let digitos_cpf:lista_digitos_cpf = obter_lista_digitos(Cpf, info);

  if (digitos_cpf.length < 9) {
    if (info.toLowerCase() === 'i' || info.toLowerCase() === 'a') {
      let e = `Foi recebido um número de CPF com apenas ${digitos_cpf.length} `
      e += "dígitos: o CPF deve ter ao menos 9 dígitos";
      console.error(e);
    }
  
    return [];
  }

  let cpf_informado = `${digitos_cpf.slice(0,3).join("")}`;
  cpf_informado += `.${digitos_cpf.slice(3,6).join("")}`;
  cpf_informado += `.${digitos_cpf.slice(6,9).join("")}`;

  if (info.toLowerCase() === 'i' || info.toLowerCase() === 'a') {
    console.log(`CPF informado: ${cpf_informado}`);
  };

  let dv_1:digito_verificador_cpf = calcular_dv(digitos_cpf);
  digitos_cpf.push(dv_1);
  let dv_2:digito_verificador_cpf = calcular_dv(digitos_cpf);

  if (info.toLowerCase() === 'i' || info.toLowerCase() === 'a') {
    console.log(`CPF completo:  ${cpf_informado}-${dv_1}${dv_2}`)
  };

  return [dv_1, dv_2];
};

export default obter_dvs;
