mod cpf;

use std::vec::IntoIter;

fn main() {
    const A: &str = "A13-B09-C32";
    const B: &str = "123.456.789-09";
    const C: &str = "teste";
    const D: &str = "";
    println!("A = \"{}\";    reter_numeros(A) = \"{}\", n = 11", A, cpf::reter_numeros(A, 11));
    println!("B = \"{}\"; reter_numeros(B) = \"{}\",   n = 9", B, cpf::reter_numeros(B, 9));
    println!("C = \"{}\";          reter_numeros(C) = \"{}\",            n = 11", C, cpf::reter_numeros(C, 11));
    println!("D = \"{}\";               reter_numeros(D) = \"{}\",            n = 1", D, cpf::reter_numeros(D, 1));
    println!();
    let digitos_a1: IntoIter<i32> = cpf::obter_digitos(A, 11);
    println!("- comprimento : digitos.len() = {}", digitos_a1.len());
    println!("-       valor : digitos = {:?}", digitos_a1);
    println!();
    let digitos_a2: IntoIter<i32> = cpf::obter_digitos(A, 9);
    println!("- comprimento : digitos.len() = {}", digitos_a2.len());
    println!("-       valor : digitos = {:?}", digitos_a2);
    println!();
    let digitos_b1: IntoIter<i32> = cpf::obter_digitos(B, 11);
    println!("- comprimento : digitos.len() = {}", digitos_b1.len());
    println!("-       valor : digitos = {:?}", digitos_b1);
    println!();
    let digitos_b2: IntoIter<i32> = cpf::obter_digitos(B, 9);
    println!("- comprimento : digitos.len() = {}", digitos_b2.len());
    println!("-       valor : digitos = {:?}", digitos_b2)
}
