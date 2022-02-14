import verificar_cpf from "./verificar_digitos_cpf";

type numero_cpf = string | number;

let cpf_completo:numero_cpf = process.argv[2];
/* "cpf_completo" recebe um argumento através da linha de comando, para
que o número de CPF cujos dígitos serão verificados possa ser informado
diretamente através da CLI.
Exemplo: ts-node CLI_verificar_digitos_cpf.ts 111444777 */

let info:string = process.argv[3]
/* "info" também recebe um argumento via linha de comando: se receber
'i', 'I', 'a' ou 'A', serão exibidas informações adicionais. */

function main() {
  return verificar_cpf(cpf_completo, info)
}

console.log(main())
