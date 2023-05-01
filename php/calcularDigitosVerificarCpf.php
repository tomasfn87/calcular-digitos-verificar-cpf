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
        for ($i = 0; $i < 9; $i++) {
            $soma += (int)$nums[$i] * $multiplicador; 
            $multiplicador -= 1;}
        $resto = $soma % 11;
        if ($resto > 1) {
            $dvs[0] = 11 - $resto;}
        $multiplicador = 11;
        $resto = 0;
        $soma = 0;
        for ($i = 0; $i < 9; $i++) {
            $soma += (int)$nums[$i] * $multiplicador; 
            $multiplicador -= 1;}
        $soma += $dvs[0] * $multiplicador;
        $resto = $soma % 11;
        if ($resto > 1) {
            $dvs[1] = 11 - $resto;}
        if ($loud == true) {
            $Cpf = sprintf('%s.%s.%s-%d%d',
               substr($nums, 0, 3), substr($nums, 3, 3),
               substr($nums, 6, 3), $dvs[0], $dvs[1]);
            echo $Cpf, "\n";
            echo preg_replace('/\D/', '', $Cpf), "\n";}
        return $dvs;}
    
    function verificar(string $cpf, bool $loud=false) {
        if (strlen(reterNumeros($cpf, 1)) < 1) {
            return false;} 
        $dvs_recebidos = [ 0, 0 ];
        $dvs_recebidos[0] = (int)reterNumeros($cpf, 11)[9];
        $dvs_recebidos[1] = (int)reterNumeros($cpf, 11)[10];
        $dvs_calculados = calcularDigitos(substr(reterNumeros($cpf, 11), 0, 9)); 
        $valido = false;
        $resultado = "inválido";
        if ($dvs_recebidos[0] == $dvs_calculados[0] &&
            $dvs_recebidos[1] == $dvs_calculados[1]) {
            $valido = true;
            $resultado = substr($resultado, 2);}
        if ($loud) {
            $c = reterNumeros($cpf, 11);
            $Cpf = sprintf('%s.%s.%s-%s',
                substr($c, 0, 3), substr($c, 3, 3),
                substr($c, 6, 3), substr($c, 9, 2));
            echo 'O CPF ', $Cpf, ' é ', $resultado, ".\n";}
        return $valido;}
    
    if (sizeof($argv) == 2) {
        if ($argv[1] == '--demo') {
            $vals1 = [ "7", 1 ];
            $vals2 = [ "5a8", 1 ];
            $vals3 = [ "2a7", 2 ];
            $vals4 = [ "1a5", 4 ];
            echo " * Reter Números\n";
            echo '   - reterNumeros("', $vals1[0], '", ', $vals1[1] , ') = "', reterNumeros($vals1[0], $vals1[1]), '"', "\n";
            echo '   - reterNumeros("', $vals2[0], '", ', $vals2[1] , ') = "', reterNumeros($vals2[0], $vals2[1]), '"', "\n";
            echo '   - reterNumeros("', $vals3[0], '", ', $vals3[1] , ') = "', reterNumeros($vals3[0], $vals3[1]), '"', "\n";
            echo '   - reterNumeros("', $vals4[0], '", ', $vals4[1] , ') = "', reterNumeros($vals4[0], $vals4[1]), '"', "\n";
            echo "\n";
            echo " * Calcular Dígitos\n";
            $vals5 = 'abc';
            $vals6 = '123';
            $vals7 = '47';
            $test1 = calcularDigitos($vals5);
            $test2 = calcularDigitos($vals6);
            $test3 = calcularDigitos($vals7);
            echo '   - calcularDigitos("', $vals5, '") = {';
            if (sizeof($test1) > 0) {
                echo ' ', $test1[0], ', ', $test1[1], ' ';}
            echo "}\n";
            echo '   - calcularDigitos("', $vals6, '") = {';
            if (sizeof($test2) > 0) {
                echo ' ', $test2[0], ', ', $test2[1], ' ';}
            echo "}\n";
            echo '   - calcularDigitos("', $vals7, '") = {';
            if (sizeof($test3) > 0) {
                echo ' ', $test3[0], ', ', $test3[1], ' ';}
            echo "}\n";
            echo "\n";
            echo " * Verificar\n";
            $vals8 = '12359';
            $vals9 = '4774';
            $resultadoTeste4 = 'false';
            $resultadoTeste5 = 'false';
            $resultadoTeste6 = 'false';
            $test4 = verificar($vals5);
            $test5 = verificar($vals8);
            $test6 = verificar($vals9);
            if ($test4) {
                $resultadoTeste4 = 'true';}
            if ($test5) {
                $resultadoTeste5 = 'true';}
            if ($test6) {
                $resultadoTeste6 = 'true';}
            echo '   - verificar("', $vals5, '") = ', $resultadoTeste4, "\n";
            echo '   - verificar("', $vals8, '") = ', $resultadoTeste5, "\n";
            echo '   - verificar("', $vals9, '") = ', $resultadoTeste6, "\n";}}
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
                verificar($argv[2], true);}}}?>
