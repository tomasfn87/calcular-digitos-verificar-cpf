use autobox::universal qw(type);
use strict;
use warnings;

sub main {
    if (scalar(@ARGV) == 1 and $ARGV[0] eq "--demo") {
        print " * reter_numeros(texto, n)\n\n";
        print "    reter_numeros(\"test1\", 1) = ",
            color("green", "\"" . reter_numeros("test1", 1) . "\""), "\n";
        print "   reter_numeros(\"test1\", 11) = ",
            color("green", "\"" . reter_numeros("test1", 11) . "\""), "\n";
        print "------------------------------------------------\n";
        print " * formatar(CPF)\n\n";
        print "                formatar(\"0\") = " . color("green", "\""),
            formatar(2, "0"), color("green", "\""), "\n";
        print "            formatar(\"12360\") = " . color("green", "\""),
            formatar(2, "12360"), color("green", "\""), "\n";
        print "------------------------------------------------\n";
        print " * calcular_digitos(CPF)\n\n";
        print "        calcular_digitos(\"0\") = ",
            printable_array(1, calcular_digitos("0")), "\n";
        print "      calcular_digitos(\"192\") = ",
            printable_array(1, calcular_digitos("192")), "\n";
        print "      calcular_digitos(\"123\") = ",
            printable_array(1, calcular_digitos("123")), "\n";
        print "------------------------------------------------\n";
        print " * verificar(CPF)\n\n";
        print "               verificar(\"0\") = ",
            color("yellow", verificar("0")), "\n";
        print "           verificar(\"19293\") = ",
            color("yellow", verificar("19293")), "\n";
        print "           verificar(\"12360\") = ",
            color("yellow", verificar("12360")), "\n";}
    elsif (scalar(@ARGV) == 2 and
        ($ARGV[0] eq "-f" or $ARGV[0] eq "--formatar")) {
        if (!length(reter_numeros($ARGV[1], 1))) {
            print color("red", "ERRO"), ": informe um número de ",
                color("yellow", "CPF"), " para efetuar a formatação.\n"}
        else {
            print "CPF formatado: ", formatar(1, $ARGV[1]), "\n"}}
    elsif (scalar(@ARGV) == 2 and
        ($ARGV[0] eq "-c" or $ARGV[0] eq "--calcular")) {
        if (!length(reter_numeros($ARGV[1], 1))) {
            print color("red", "ERRO"), ": informe um número de ",
                color("yellow", "CPF"),
                    " para efetuar o cálculo dos dígitos verificadores.\n"}
        else {
            my @dvs = calcular_digitos($ARGV[1]);
            my $cpfCompleto = reter_numeros($ARGV[1], 9) . $dvs[0] . $dvs[1];
            print "CPF informado: ", formatar(3, $cpfCompleto), "\n";
            print "CPF completo:  ", formatar(1, $cpfCompleto), "\n";
            print "               ",
                color("yellow", reter_numeros($cpfCompleto, 11)), "\n";
            print printable_array(1, @dvs), "\n"}}
    elsif (scalar(@ARGV) == 2 and
        ($ARGV[0] eq "-v" or $ARGV[0] eq "--verificar")) {
        if (!length(reter_numeros($ARGV[1], 1))) {
            print color("red", "ERRO"), ": informe um número de ",
                color("yellow", "CPF"), " para efetuar a verificação.\n"}
        else {
            my $valid = verificar($ARGV[1]);
            print "O CPF ", formatar(1, $ARGV[1]), " é ";
            if ($valid) {
                print color("green", "válido")}
            else {
                print color("red", "inválido")}
            print ".\n"}}
    else {
        print "Digite uma das opções abaixo:\n";
        print " * '--demo' para visualizar entradas e saídas das funções do programa;\n";
        print " * '-f' ou '--formatar' e um número de CPF para obter o CPF formatado no formato XXX.XXX.XXX-DD;\n";
        print " * '-c' ou '--calcular' e um número de CPF para calcular os dígitos verificadores do CPF;\n";
        print " * '-v' ou '--verificar' e um número de CPF para verificar se o número é valido.\n"}}

sub verificar {
    my ($CPF) = @_;
    my $cpf = reter_numeros($CPF, 11);
    if (!length($cpf)) {
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
    if (!length($cpf)) {
        return undef}
    my @dvs = ( 0, 0 );
    my ($soma, $multiplicador) = (0, $num_digitos + 1);
    for my $c (split //, $cpf) {
        $soma += int($c) * $multiplicador;
        $multiplicador -= 1}
    my $resto = $soma % 11;
    if ($resto > 1) {
        $dvs[0] = 11 - $resto}
    ($soma, $multiplicador) = (0, $num_digitos + 2);
    for my $c (split //, $cpf) {
        $soma += int($c) * $multiplicador;
        $multiplicador -= 1}
    $soma += $dvs[0] * $multiplicador;
    $resto = $soma % 11;
    if ($resto > 1) {
        $dvs[1] = 11 - $resto}
    return @dvs}

sub formatar {
    my ($colors_on, $CPF) = @_;
    $colors_on ||= 0;
    my $cpf = reter_numeros($CPF, 11);
    if (!length($cpf)) {
        return undef}
    my $cpfF = "";
    if ($colors_on == 1) {
        $cpfF = color("yellow", substr($cpf, 0, 3)) .
            "." . color("yellow", substr($cpf, 3, 3)) .
            "." . color("yellow", substr($cpf, 6, 3)) .
            "-" . color("yellow", substr($cpf, 9, 2))}
    elsif ($colors_on == 2) {
        $cpfF = color("green", substr($cpf, 0, 3)) .
            "." . color("green", substr($cpf, 3, 3)) .
            "." . color("green", substr($cpf, 6, 3)) .
            "-" . color("green", substr($cpf, 9, 2))}
    elsif ($colors_on == 3) {
        $cpfF = color("blue", substr($cpf, 0, 3)) .
            "." . color("blue", substr($cpf, 3, 3)) .
            "." . color("blue", substr($cpf, 6, 3))}
    else {
        $cpfF = substr($cpf, 0, 3) .
            "." . substr($cpf, 3, 3) .
            "." . substr($cpf, 6, 3) .
            "-" . substr($cpf, 9, 2)}
    return $cpfF}

sub reter_numeros {
    my ($texto, $n) = @_;
    my ($apenas_nums, $cont) = ("", 0);
    for my $c (split //, $texto) {
        if (ord($c) > 47 && ord($c) < 58) {
            $apenas_nums .= $c;
            $cont++}
        if ($cont == $n) {
            last}}
    if (!length($apenas_nums)) {
        return ""}
    while (length($apenas_nums) < $n) {
        $apenas_nums = "0" . $apenas_nums}
    return $apenas_nums}

sub color {
    my ($color, $text) = @_;
    my ($red, $green, $yellow, $blue, $reset) =
        ("\e[31m", "\e[32m", "\e[33m", "\e[34m", "\e[0m");
    my @colors = ("red", "green", "yellow", "blue");
    my $ok = 0;
    for my $c (@colors) {
        if ($color eq $c) {
            $ok++; last}}
    if (!$ok) {
        return $text}
    if ($color eq "red") {
        return $red . $text . $reset}
    elsif ($color eq "green") {
        return $green . $text . $reset}
    elsif ($color eq "yellow") {
        return $yellow . $text . $reset}
    elsif ($color eq "blue") {
        return $blue . $text . $reset}}

sub printable_array {
    my ($color_on, @arr) = @_;
    $color_on ||= 0;
    if (!scalar(@arr)) {
        return "()"}
    my $p_arr = "";
    if ($color_on) {
        for my $i (0..($#arr - 1)) {
            if (type($arr[$i]) eq "STRING") {
                $p_arr .= " " . color("green", "\"$arr[$i]\"") . ","}
            else {
                $p_arr .= " " . color("yellow", "$arr[$i]") . ","}}}
    else {
        for my $i (0..($#arr - 1)) {
            $p_arr .= " $arr[$i],";}}
    if ($color_on) {
        if (type($arr[$#arr]) eq "STRING") {
            $p_arr .= " " . color("green", "\"$arr[$#arr]\"")}
        else {
            $p_arr .= " " . color("yellow", "$arr[$#arr]")}}
    else {
        $p_arr .= " $arr[$#arr]"}
    return "(" . $p_arr . " )"}

main()