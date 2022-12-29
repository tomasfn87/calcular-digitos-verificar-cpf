use lazy_static::lazy_static;
use pad::{PadStr, Alignment};
use regex::Regex;
use std::vec::IntoIter;

pub fn reter_numeros(cpf: &str, n: usize) -> String {
    /*
    Argumento:
    ---------
    - cpf: ponteiro para string com números que serão isolados
        de caracteres não numéricos; caso não existam caracteres
        numéricos, será devolvida uma string vazia.
    - n: inteiro que corresponde à quantidade de dígitos desejada, a
        depender da operação em questão:
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
    return String::from("")
}

pub fn obter_digitos(cpf: &str, n: usize) -> IntoIter<i32> {
    /*
    Argumentos:
    ----------
    - cpf: string com números que serão filtrados e transformados em
        inteiros para execução do cálculo de CPF;
    - n: inteiro que corresponde à quantidade de dígitos desejada, a
        depender da operação em questão:
        -  9 dígitos -> Cálculo dos dígitos verificadores de CPF;
        - 11 dígitos -> Verificação do número de CPF.
    */
    println!("-       valor : cpf = \"{}\"", cpf);
    println!("- comprimento : cpf.len() = {}", cpf.len());
    let cpf_filtrado = &reter_numeros(&cpf, n);
    println!("-       valor : cpf_filtrado = \"{}\"", cpf_filtrado);
    println!("- comprimento : cpf_filtrado.len() = {}", cpf_filtrado.len());
    let mut digitos = vec![];
    println!("- comprimento : digitos.len() = {}", digitos.len());
    println!("-       valor : digitos = {:?}", digitos);
    let mut i = 0;
    while i < cpf_filtrado.len() && i < n {
        let d = cpf_filtrado.chars().nth(i).unwrap().to_string().parse::<i32>().unwrap();
        digitos.extend(vec![d]);
        // println!("  -> digitos[{}] = {}", i, digitos[i]);
        i += 1
    }
    return digitos.into_iter()
}
