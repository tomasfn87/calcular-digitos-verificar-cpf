import obter_dvs from "./calcular_digitos_cpf"

type numero_cpf = string | number;

// const Cpf:numero_cpf = 111444777
const Cpf:numero_cpf = process.argv[2];
/* "Cpf" recebe um argumento através da linha de comando, para que o
número de CPF cujos dígitos serão calculados possa ser informado
diretamente através da CLI.
Exemplo: ts-node CLI_calcular_digitos_cpf.ts 111444777 */

let info:string = process.argv[3];
/* "info" também recebe um argumento via linha de comando: se receber
'i', 'I', 'a' ou 'A', serão exibidas informações adicionais. */


function main() {
  return obter_dvs(Cpf, info)
}

console.log(main())
