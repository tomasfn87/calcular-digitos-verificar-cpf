sub print_array {
    my (@array) = @_;
    print "( ";
    my $last_item_index = scalar(@array) - 1;
    for my $i (0..$#array) {
        if ($i == $last_item_index) {
            print "$array[$i] )\n";
            last;}
        else {
            print "$array[$i], ";}}}

sub reter_numeros {
    my ($texto, $n) = @_;
    my $only_nums = "";
    my $counter = 0;
    for my $c (split //, $texto) {
        if (ord($c) > 47 && ord($c) < 58) {
            $only_nums .= $c;
            $counter++;}
        if ($counter == $n) {
            last;}}
    if (length($only_nums) == 0) {
        return "";}
    while (length($only_nums) < $n) {
        $only_nums = "0" . $only_nums;}
    return $only_nums;}

sub calcular_digitos {
    my ($CPF) = @_;
    my $cpf = reter_numeros($CPF, 9);
    if (length($cpf) < 1) {
        return undef;}
    my @dvs = ( 0, 0 );
    my ($soma, $multiplicador) = (0, 10);
    for my $c (split //, $cpf) {
        $soma += int($c) * $multiplicador;
        $multiplicador -= 1;}
    my $resto = $soma % 11;
    if ($resto > 1) {
        @dvs[0] = 11 - $resto;}
    ($soma, $multiplicador) = (0, 11);
    for my $c (split //, $cpf) {
        $soma += int($c) * $multiplicador;
        $multiplicador -= 1;}
    $soma += @dvs[0] * $multiplicador;
    $resto = $soma % 11;
    if ($resto > 1) {
        @dvs[1] = 11 - $resto;}
    return @dvs;}

sub verificar {
    my ($CPF) = @_;
    my $cpf = reter_numeros($CPF, 11);
    if (length($cpf) < 1) {
        return undef;}
    my @dvs_recebidos = (
        int(substr($cpf, 9, 1)),
        int(substr($cpf, 10, 1)));
    my @dvs_calculados = calcular_digitos(substr($cpf, 0, 9));
    if (
        @dvs_calculados[0] == @dvs_recebidos[0] and
        @dvs_calculados[1] == @dvs_recebidos[1]) {
        return 1;}
    return 0;}

print("reter_numeros(\"test1\", 1) = ", reter_numeros("test1", 1), "\n");
print("reter_numeros(\"test1\", 11) = ", reter_numeros("test1", 11), "\n");
print "\n";
print("calcular_digitos(\"0\") = ");
print_array(calcular_digitos("0"));
print("calcular_digitos(\"192\") = ");
print_array(calcular_digitos("192"));
print("calcular_digitos(\"123\") = ");
print_array(calcular_digitos("123"));
print "\n";
print("verificar(\"0\") = ", verificar("0"), "\n");
print("verificar(\"19293\") = ", verificar("19293"), "\n");
print("verificar(\"12360\") = ", verificar("12360"), "\n");