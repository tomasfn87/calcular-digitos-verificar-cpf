import cpf;
import std.stdio;

void main() {
	writeln("   reter_numeros(\"test\", 1) = \"", reter_numeros("test", 1), "\"");
	writeln("reter_numeros(\"test123\", 0) = \"", reter_numeros("test123", 0), "\"");
	writeln("reter_numeros(\"test123\", 1) = \"", reter_numeros("test123", 1), "\"");
	writeln("reter_numeros(\"test123\", 2) = \"", reter_numeros("test123", 2), "\"");
	writeln("reter_numeros(\"test123\", 4) = \"", reter_numeros("test123", 4), "\"");
	writeln("  calcular_digitos(\"test0\") = ", calcular_digitos("test0"));
	writeln("  calcular_digitos(\"test1\") = ", calcular_digitos("test1"));
	writeln("calcular_digitos(\"test123\") = ", calcular_digitos("test123"));
	writeln("     verificar(\"test19290\") = ", verificar("test19290"));
	writeln("     verificar(\"test19291\") = ", verificar("test19291"));
	writeln("     verificar(\"test12360\") = ", verificar("test12360"));}
