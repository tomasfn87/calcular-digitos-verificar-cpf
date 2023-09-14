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

print(reter_numeros("test1", 1), "\n");
print(reter_numeros("test1", 11), "\n");
