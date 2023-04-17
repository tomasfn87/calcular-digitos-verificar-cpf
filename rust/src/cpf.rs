use lazy_static::lazy_static;
use pad::{PadStr, Alignment};
use regex::Regex;
use std::vec::IntoIter;
use substring::Substring;


pub fn verificar(cpf: &str) -> bool {
    /*
    - cpf: string (texto) com o número de CPF, com ou sem marcação; o
        número será tratado como um CPF completo; seus dígitos finais
        serão comparados com os dígitos calculados a partir dos 9
        primeiros dígitos.
    */
    if reter_numeros(cpf, 1) == "" {
         println!("ERRO: informe um CPF válido para verificação");
         return false
    }
    let mut digitos_recebidos = vec![];
    let mut c: u8 = 0;
    for d in obter_digitos(cpf, 11) {
        if c == 9 || c == 10 {
            digitos_recebidos.extend(vec![d]);
        }
        c += 1
    }
    let cpf_calculo = reter_numeros(cpf, 11).to_string();
    let digitos_calculados: [u16; 2] = calcular_digitos(&cpf_calculo.substring(0, 9));
    if digitos_recebidos[0] == digitos_calculados[0]
        && digitos_recebidos[1] == digitos_calculados[1] {
        return true
    }
    false
}

pub fn obter_digitos(cpf: &str, n: usize) -> IntoIter<u16> {
    /*
    - cpf: string com números que serão filtrados e transformados em
        inteiros para execução do cálculo de CPF;
    - n: inteiro que corresponde à quantidade de dígitos desejada, a
        depender da operação em questão:
        -  9 dígitos -> Cálculo dos dígitos verificadores de CPF;
        - 11 dígitos -> Verificação do número de CPF.
    */
    let cpf_filtrado = &reter_numeros(&cpf, n);
    let mut digitos = vec![];
    let mut i: usize = 0;
    while i < cpf_filtrado.len() && i < n {
        let d = cpf_filtrado.chars().nth(i).unwrap().to_string().parse::<u16>().unwrap();
        digitos.extend(vec![d]);
        i += 1
    }
    digitos.into_iter()
}

pub fn calcular_digitos(cpf: &str) -> [u16; 2] {
    /*
    - cpf: string (texto) com o número de CPF, com ou sem marcação;
        o número será encarado como um CPF incompleto (sem os dígitos
        verificadores); seus dígitos finais serão calculados pela
        função 'calcular_digito_verificador'.
    */
    if reter_numeros(cpf, 9) == "" {
        panic!("ERRO: informe um número válido.")
    }
    let mut digitos_cpf = vec![];
    for d in obter_digitos(cpf, 9) {
        digitos_cpf.extend(vec![d]);
    }
    let digito_verificador_1 = calcular_digito_verificador(&digitos_cpf);
    digitos_cpf.extend(vec![digito_verificador_1]);
    [ digito_verificador_1, calcular_digito_verificador(&digitos_cpf) ]
}

pub fn reter_numeros(cpf: &str, n: usize) -> String {
    /*
    - cpf: ponteiro para string com números que serão isolados
        de caracteres não numéricos, e então preenchidos com zeros,
        para que a string tenha o mesmo comprimento que 'n'; caso
        não existam caracteres numéricos, será devolvida uma
        string vazia.
    - n: inteiro que corresponde à quantidade de dígitos desejada (e
        também ao comprimento final da string retornada, a depender
        da operação em questão:
        -  9 dígitos -> Cálculo dos dígitos verificadores de CPF;
        - 11 dígitos -> Verificação do número de CPF.
    */
    lazy_static! {
        static ref REGEXP_NUMBERS: Regex = Regex::new(r"\d").unwrap();
    }
    lazy_static! {
        static ref REGEXP_NON_NUMBERS: Regex = Regex::new(r"\D").unwrap();
    }
    if REGEXP_NUMBERS.is_match(cpf) {
        let number_string = REGEXP_NON_NUMBERS.replace_all(cpf, "").to_string();
        return number_string.pad(n, '0', Alignment::Right, true)
    }
    String::from("")
}

fn calcular_digito_verificador(digitos: &[u16]) -> u16 {
    /*
    - digitos: slice contendo 9 ou 10 dígitos para efetuar o cálculo
        dos dígitos verificadores.
    */
    let mut soma: u16 = 0;
    let mut multiplicador: u16 = u16::try_from(digitos.len()).unwrap();
    multiplicador += 1;
    for d in digitos {
        soma += d * multiplicador;
        multiplicador -= 1
    }
    let resto: u16 = soma % 11;
    if resto > 1 {
        return 11 - resto
    }
    0
}
