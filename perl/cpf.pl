use strict;
use warnings;

sub main {
    if (scalar(@ARGV) == 1 and $ARGV[0] eq "--demo") {
        print " * reter_numeros(texto, n)\n\n";
        print "    reter_numeros(\"test1\", 1) = \"", reter_numeros("test1", 1), "\"\n";
        print "   reter_numeros(\"test1\", 11) = \"", reter_numeros("test1", 11), "\"\n";
        print "------------------------------------------------\n";
        print " * formatar(CPF)\n\n";
        print "                formatar(\"0\") = \"", formatar("0"), "\"\n";
        print "             formtar(\"12360\") = \"", formatar("12360"), "\"\n";
        print "------------------------------------------------\n";
        print " * calcular_digitos(CPF)\n\n";
        print "        calcular_digitos(\"0\") = ", printable_array(calcular_digitos("0")), "\n";
        print "      calcular_digitos(\"192\") = ", printable_array(calcular_digitos("192")), "\n";
        print "      calcular_digitos(\"123\") = ", printable_array(calcular_digitos("123")), "\n";
        print "------------------------------------------------\n";
        print " * verificar(CPF)\n\n";
        print "               verificar(\"0\") = ", verificar("0"), "\n";
        print "           verificar(\"19293\") = ", verificar("19293"), "\n";
        print "           verificar(\"12360\") = ", verificar("12360"), "\n";}
    elsif (scalar(@ARGV) == 2 and ($ARGV[0] eq "-f" or $ARGV[0] eq "--formatar")) {
        if (!length(reter_numeros($ARGV[1], 1))) {
            print add_color("red", "ERRO"), ": informe um número de ", add_color("yellow", "CPF"), " para efetuar a formatação.\n";}
        else {
            print "CPF formatado: ", add_color("yellow", formatar($ARGV[1])), "\n";}}
    elsif (scalar(@ARGV) == 2 and ($ARGV[0] eq "-c" or $ARGV[0] eq "--calcular")) {
        if (!length(reter_numeros($ARGV[1], 1))) {
            print add_color("red", "ERRO"), ": informe um número de ", add_color("yellow", "CPF"), " para efetuar o cálculo dos dígitos verificadores.\n";}
        else {
            my @dvs = calcular_digitos($ARGV[1]);
            my $cpfCompleto = reter_numeros($ARGV[1], 9) . $dvs[0] . $dvs[1];
            print "CPF informado: ", add_color("blue", substr(formatar($cpfCompleto), 0, 11)), "\n";
            print "CPF completo:  ", add_color("yellow", formatar($cpfCompleto)), "\n";
            print "               ", add_color("yellow", reter_numeros($cpfCompleto, 11)), "\n";
            print printable_array(@dvs), "\n";}}
    elsif (scalar(@ARGV) == 2 and ($ARGV[0] eq "-v" or $ARGV[0] eq "--verificar")) {
        if (!length(reter_numeros($ARGV[1], 1))) {
            print add_color("red", "ERRO"), ": informe um número de ", add_color("yellow", "CPF"), " para efetuar a verificação.\n";}
        else {
            my $valid = verificar($ARGV[1]);
            if ($valid) {
                print "O CPF ", add_color("yellow", formatar($ARGV[1])), " é ", add_color("green", "válido"), ".\n"}
            else {
                print "O CPF ", add_color("yellow", formatar($ARGV[1])), " é ", add_color("red", "inválido"), ".\n";}}}
    else {
        print "Digite uma das opções abaixo:\n";
        print " * '--demo' para visualizar entradas e saídas das funções do programa;\n";
        print " * '-f' ou '--formatar' e um número de CPF para obter o CPF formatado no formato XXX.XXX.XXX-DD;\n";
        print " * '-c' ou '--calcular' e um número de CPF para calcular os dígitos verificadores do CPF;\n";
        print " * '-v' ou '--verificar' e um número de CPF para verificar se o número é valido.\n";}}

sub verificar {
    my ($CPF) = @_;
    my $cpf = reter_numeros($CPF, 11);
    if (length($cpf) < 1) {
        return undef}
    my @dvs_recebidos = (
        int(substr($cpf, 9, 1)),
        int(substr($cpf, 10, 1)));
    my @dvs_calculados = calcular_digitos(substr($cpf, 0, 9));
    if (
        $dvs_calculados[0] == $dvs_recebidos[0] and
        $dvs_calculados[1] == $dvs_recebidos[1]) {
        return 1}
    return 0}

sub calcular_digitos {
    my ($CPF) = @_;
    my $num_digitos = 9;
    my $cpf = reter_numeros($CPF, $num_digitos);
    if (length($cpf) < 1) {
        return undef}
    my @dvs = ( 0, 0 );
    my ($soma, $multiplicador) = (0, $num_digitos + 1);
    for my $c (split //, $cpf) {
        $soma += int($c) * $multiplicador;
        $multiplicador -= 1;}
    my $resto = $soma % 11;
    if ($resto > 1) {
        $dvs[0] = 11 - $resto;}
    ($soma, $multiplicador) = (0, $num_digitos + 2);
    for my $c (split //, $cpf) {
        $soma += int($c) * $multiplicador;
        $multiplicador -= 1;}
    $soma += $dvs[0] * $multiplicador;
    $resto = $soma % 11;
    if ($resto > 1) {
        $dvs[1] = 11 - $resto;}
    return @dvs}

sub formatar {
    my ($CPF) = @_;
    my $cpf = reter_numeros($CPF, 11);
    if (length($cpf) < 1) {
        return undef}
    my $cpfF = substr($cpf, 0, 3) .
        "." . substr($cpf, 3, 3) .
        "." . substr($cpf, 6, 3) .
        "-" . substr($cpf, 9, 2);
    return $cpfF}

sub reter_numeros {
    my ($texto, $n) = @_;
    my ($apenas_nums, $cont) = ("", 0);
    for my $c (split //, $texto) {
        if (ord($c) > 47 && ord($c) < 58) {
            $apenas_nums .= $c;
            $cont++;}
        if ($cont == $n) {
            last;}}
    if (length($apenas_nums) == 0) {
        return "";}
    while (length($apenas_nums) < $n) {
        $apenas_nums = "0" . $apenas_nums;}
    return $apenas_nums}

sub add_color {
    my ($color, $text) = @_;
    my ($red, $green, $yellow, $blue, $reset) = ("\e[31m", "\e[32m", "\e[33m", "\e[34m", "\e[0m");
    my @colors = ("red", "green", "yellow", "blue");
    my $ok = 0;
    for my $c (@colors) {
        if ($color eq $c) {
            $ok++;
            last;}}
    if (!$ok) {
        return $text;}
    if ($color eq "red") {
        return $red . $text . $reset}
    elsif ($color eq "green") {
        return $green . $text . $reset}
    elsif ($color eq "yellow") {
        return $yellow . $text . $reset}
    elsif ($color eq "blue") {
        return $blue . $text . $reset}}

sub printable_array {
    my (@arr) = @_;
    my $p_arr = "(";
    for my $i (0..$#arr) {
        $p_arr .= " $arr[$i]";
        if ($i == $#arr) {
            $p_arr .= " ";
            last;}
        $p_arr .= ",";}
    return $p_arr . ")"}

main();
