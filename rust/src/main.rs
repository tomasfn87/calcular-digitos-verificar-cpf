mod cpf;

use std::env;
use std::vec::IntoIter;

fn main() {
    let args: Vec<_> = env::args().collect();
    if args.len() > 2 {
        if &args[1] == "--demo" {
            const A: &str = "A13-B09-C32";
            const B: &str = "111.444.777-35";
            const C: &str = "teste";
            const D: &str = "";
            println!("A = \"{}\";    reter_numeros(A, 11) = \"{}\"", A, cpf::reter_numeros(A, 11));
            println!("B = \"{}\"; reter_numeros(B, 9)  = \"{}\"", B, cpf::reter_numeros(B, 9));
            println!("C = \"{}\";          reter_numeros(C, 11) = \"{}\"", C, cpf::reter_numeros(C, 11));
            println!("D = \"{}\";               reter_numeros(D, 1)  = \"{}\"", D, cpf::reter_numeros(D, 1));
            println!();
            let digitos_a1: IntoIter<u16> = cpf::obter_digitos(A, 11);
            println!("                      CPF A = {A}");
            println!("        CPF A, 11 : digitos = {:?}", digitos_a1);
            let digitos_a2: IntoIter<u16> = cpf::obter_digitos(A, 9);
            println!("        CPF A,  9 : digitos = {:?}", digitos_a2);
            print!("Digitos verificadores CPF A = [ ");
            for d in cpf::calcular_digitos(A) {
                print!("{} ", d)}
            println!("]");
            print!("          Verificação CPF A = ");
            println!("{}", cpf::verificar(A));
            println!();
            println!("                      CPF B = {B}");
            let digitos_b1: IntoIter<u16> = cpf::obter_digitos(B, 11);
            println!("        CPF B, 11 : digitos = {:?}", digitos_b1);
            let digitos_b2: IntoIter<u16> = cpf::obter_digitos(B, 9);
            println!("        CPF B,  9 : digitos = {:?}", digitos_b2);
            print!("Digitos verificadores CPF B = [ ");
            for d in cpf::calcular_digitos(B) {
                print!("{} ", d)}
            println!("]");
            print!("          Verificação CPF B = ");
            println!("{}", cpf::verificar(B));}
        else if &args[1] == "-v" || &args[1] == "--verificar" {
            if cpf::reter_numeros(&args[2], 1).len() > 0 {
                if cpf::verificar(&args[2]) {
                    println!("O CPF é válido.");}
                else {
                    println!("O CPF é inválido.");}}
            else {
                println!("ERRO: o CPF deve possuir ao menos um caracter numérico para que a verificação seja efetuada.");}}
        else if &args[1] == "-c" || &args[1] == "--calcular" {
            if cpf::reter_numeros(&args[2], 1).len() > 0 {
                let cpf = cpf::reter_numeros(&args[2], 9);
                let digitos_cpf = cpf::calcular_digitos(&args[2]);
                println!("{}.{}.{}-{}{}",
                    &cpf[0..3], &cpf[3..6], &cpf[6..9],
                    &digitos_cpf[0], &digitos_cpf[1]);
                println!("{}{}{}", &cpf[0..9],
                    &digitos_cpf[0], &digitos_cpf[1]);
                println!("[ {}, {} ]",&digitos_cpf[0], &digitos_cpf[1]);}
            else {
                println!("ERRO: o CPF deve possuir ao menos um caracter numérico para que o cálculo dos dígitos verificadores seja efetuado.");}}}
    else {
        println!("Digite '-v' ou '--verificar' e um CPF para executar a verificação;");
        println!("Digite '-c' ou '--calcular' e um CPF para executar o cálculo dos dígitos verificadores;");
        println!("Digite '--demo' para ver algumas funções do projeto em ação.");}}
