<?php declare(strict_types=1);
    function reterNumeros(string $cpf, int $n) {
        $cpf = preg_replace('/\D/', '', $cpf);
        if (strlen($cpf) < 1) {
            return '';}
        return str_pad(substr($cpf, 0, $n), $n, '0', STR_PAD_LEFT);}
    
    function calcularDigitos(string $cpf, bool $loud=false) {
        $nums = reterNumeros($cpf, 9);
        if (strlen($nums) < 1) {
            return [];} 
        $dvs = [ 0, 0 ];
        $multiplicador = 10;
        $resto = 0;
        $soma = 0;
        for ($i = 0; $i < strlen($nums); $i++) {
            $soma += (int)$nums[$i] * $multiplicador; 
            $multiplicador -= 1;}
        $resto = $soma % 11;
        if ($resto > 1) {
            $dvs[0] = 11 - $resto;}
        $multiplicador = 11;
        $resto = 0;
        $soma = 0;
        for ($i = 0; $i < strlen($nums); $i++) {
            $soma += (int)$nums[$i] * $multiplicador; 
            $multiplicador -= 1;}
        $soma += $dvs[0] * $multiplicador;
        $resto = $soma % 11;
        if ($resto > 1) {
            $dvs[1] = 11 - $resto;}
        if ($loud == true) {
            echo substr($nums, 0, 3), '.',
                substr($nums, 3, 3), '.',
                substr($nums, 6, 3), '-',
                $dvs[0], $dvs[1], "\n";
            echo substr($nums, 0, 3),
                substr($nums, 3, 3),
                substr($nums, 6, 3),
                $dvs[0], $dvs[1], "\n";}
        return $dvs;}
    
    function verificar(string $cpf) {
        if (strlen(reterNumeros($cpf, 1)) < 1) {
            return false;} 
        $dvs_recebidos = [ 0, 0 ];
        $dvs_recebidos[0] = (int)reterNumeros($cpf, 11)[9];
        $dvs_recebidos[1] = (int)reterNumeros($cpf, 11)[10];
        $dvs_calculados = calcularDigitos(substr(reterNumeros($cpf, 11), 0, 9)); 
        if ($dvs_recebidos[0] == $dvs_calculados[0] &&
            $dvs_recebidos[1] == $dvs_calculados[1]) {
            return true;}
        return false;}
    
    if (sizeof($argv) == 2) {
        if ($argv[1] == '--demo') {
            echo ' * Reter Números', "\n";
            echo "   - reterNumeros('0', 1) = \"", reterNumeros('0', 1), "\"\n";
            echo "   - reterNumeros('1a2', 1) = \"", reterNumeros('1a2', 1), "\"\n";
            echo "   - reterNumeros('1a2', 2) = \"", reterNumeros('1a2', 2), "\"\n";
            echo "   - reterNumeros('1a2', 4) = \"", reterNumeros('1a2', 4), "\"\n";
            echo '', "\n";
            echo ' * Calcular Dígitos', "\n";
            $test1 = calcularDigitos('abc');
            $test2 = calcularDigitos('123');
            $test3 = calcularDigitos('47');
            echo "   - calcularDigitos('abc') = \"";
            if (sizeof($test1) > 0) {
                echo $test1[0], $test1[1], "\"\n";}
            else {
                echo "\"\n";}
            echo "   - calcularDigitos('123') = \"";
            if (sizeof($test2) > 0) {
                echo $test2[0], $test2[1], "\"\n";}
            else {
                echo "\"\n";}
            echo "   - calcularDigitos('47') = \"";
            if (sizeof($test3) > 0) {
                echo $test3[0], $test3[1], "\"\n";}
            else {
                echo "\"\n";}
            echo '', "\n";
            echo ' * Verificar', "\n";
            $test4 = verificar('abc');
            $test5 = verificar('12359');
            $test6 = verificar('4774');
            echo "   - verificar('abc') = \"", $test4, "\"\n";
            echo "   - verificar('12359') = \"", $test5, "\"\n";
            echo "   - verificar('4774') = \"", $test6, "\"\n";}}
    else if (sizeof($argv) > 2) {
        if ($argv[1] == '-c') {
            if (strlen(reterNumeros($argv[2], 1)) < 1) {  
                echo 'ERRO: digite um número de CPF válido para que os dígitos possam ser calculados.', "\n";}
            else {
                calcularDigitos($argv[2], true);}}
        else if ($argv[1] == '-v') {
            if (strlen(reterNumeros($argv[2], 1)) < 1) {
                echo 'ERRO: digite um número de CPF válido para verificação.', "\n";}
            else {
                $valido = verificar($argv[2]);
                if ($valido) {
                    echo 'CPF válido', "\n";}
                else {
                    echo 'CPF inválido', "\n";}}}}?>
