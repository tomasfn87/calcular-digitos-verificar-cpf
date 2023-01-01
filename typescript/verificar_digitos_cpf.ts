import limpar_numero from "./limpar_numero";
import obter_dvs from "./calcular_digitos_cpf";

type numero_cpf = number | string | object;
type digitos_verificadores_cpf = number[];

export const comparar_dvs = (
    /* A função "comparar_dvs" compara os dígitos do CPF recebidos com os
      dígitos do CPF calculados pela função "obter_dvs"
    */
    dvs_recebidos:digitos_verificadores_cpf,
    dvs_calculados:digitos_verificadores_cpf
) => {
    if (dvs_recebidos.length !== 2 || dvs_calculados.length !== 2)
        return false;
    for (let i=0; i < dvs_recebidos.length; i++) {
        if (dvs_recebidos[i] !== dvs_calculados[i])
            return false;
    }
    return true
}
  
const verificar_cpf = (cpf_completo:numero_cpf, info:string='n') => {
    /*  A função "verificar_cpf" testa se "cpf_completo" é uma string,
      fazendo a conversão para string em caso negativo; também checa
      se seu comprimento é diferente de 11: em caso positivo, será
      exibida uma mensagem de erro e a função retornará vazio.
        Concluídos os testes acima, serão passados os 9 primeiros
      dígitos do número de CPF para a função "obter_dvs", para que
      os dígitos do CPF sejam calculados e então armazenados em
      "dvs_calculados". Esses números serão comparados com os dígitos
      do CPF recebido: se forem iguais, será retornado o booleano
      "true", caso contrário será retornado o booleano "false".
        O parâmetro "info" tem por valor padrão 'n', e pode receber
      'i' ou 'a' (ou 'I' ou 'A'): ambas imprimirão informações
      adicionais. Nesse caso, a diferença é que 'i' mostrará apenas
      as informações adicionais de "verificar_digitos_cpf", enquanto
      'a' mostrará também as informações adicionais de
      "calcular_digitos_cpf".
    */
    cpf_completo = limpar_numero(cpf_completo, 11);
    const cpf:numero_cpf = cpf_completo.slice(0, 9);
    let dvs_calculados:number[] = [];
    if (info.toLowerCase() === "a")
        dvs_calculados = obter_dvs(cpf, info);
    else
        dvs_calculados = obter_dvs(cpf);
    const dvs_recebidos:digitos_verificadores_cpf = [
        parseInt(cpf_completo[9]), parseInt(cpf_completo[10])
    ];
    const cpf_valido = comparar_dvs(dvs_recebidos, dvs_calculados);
    let numero_cpf = `${cpf_completo.slice(0,3)}.${cpf_completo.slice(3,6)}.${cpf_completo.slice(6,9)}-${cpf_completo.slice(9,11)}`;
    const validez = cpf_valido === true ? "válido" : "inválido";
    if (info.toLowerCase() === 'i' || info.toLowerCase() === 'a')
        console.log(`O número de CPF ${numero_cpf} é ${validez}.`);
    return cpf_valido
};

export default verificar_cpf;
