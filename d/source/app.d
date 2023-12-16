import cpf;
import std.stdio;
import std.format;

void main(string[] args) {
	if (args.length < 3) {
		print_help();
		return;}

	string operation = args[1], cpf = args[2];
	if (!reter_numeros(cpf, 1).length) {
		print_help();
		return;}

	if (operation == "-v" || operation == "--verificar") {
		bool is_valid = verificar(cpf);
		write(format("O CPF %s é ", formatar(cpf)));
		if (is_valid) {
			writeln("válido.");}
		else {
			writeln("inválido.");}} 
	else 
	if (operation == "-c" || operation == "--calcular") {
		string CPF = reter_numeros(cpf, 9);
		uint[2] digitos = calcular_digitos(CPF);
		string cpf_completo = format("%s%d%d", CPF, digitos[0], digitos[1]);
		writeln("CPF informado: ", formatar(format("%s%d%d", cpf, 0, 0))[0 .. 11]);
		writeln("CPF completo:  ", formatar(cpf_completo));
		writeln("               ", cpf_completo);
		writeln(digitos);}
	else 
	if (operation == "-f" || operation == "--formatar") {
		writeln(format("CPF formatado: %s", formatar(cpf)));}
	else {
        print_help();}}

void print_help() {
	writeln("Selecione uma das opções abaixo como primeiro argumento, e um número de CPF como segundo argumento:");
	writeln(" * Digite '-v' para efetuar a verificação de um número de CPF;");
	writeln(" * Digite '-c' para efetuar o cálculo dos dígitos verificadores de um número de CPF;");
	writeln(" * Digite '-f' para efetuar a formatação de um número de CPF.");}