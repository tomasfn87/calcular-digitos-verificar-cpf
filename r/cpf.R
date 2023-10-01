reter_numeros <- function(texto, n) {
    apenas_nums <- ""
    cont <- 0
    for (char in strsplit(texto, NULL)[[1]]) {
        if (cont == n) {
            break}
        char_code <- as.integer(charToRaw(char))
        if (char_code > 47 && char_code < 58) {
            apenas_nums <- paste0(apenas_nums, char)
            cont <- cont + 1}}
    if (cont == 0) {
        return("")}
    while (nchar(apenas_nums) < n) {
        apenas_nums <- paste0("0", apenas_nums)}
    apenas_nums}

calcular_digitos_verificadores <- function(cpf) {
    num_algarismos_base <- 9
    CPF <- reter_numeros(cpf, num_algarismos_base)
    dvs <- c(0, 0)
    multiplicador <- num_algarismos_base + 1
    soma <- 0
    for (num in strsplit(CPF, NULL)[[1]]) {
        integer_value <- as.integer(charToRaw(num)) - 48
        soma <- soma + (integer_value * multiplicador)
        multiplicador <- multiplicador - 1}
    resto <- soma %% (num_algarismos_base + 2)
    if (resto > 1) {
        dvs[1] <- (num_algarismos_base + 2) - resto}
    multiplicador <- num_algarismos_base + 2
    soma <- 0
    for (num in strsplit(CPF, NULL)[[1]]) {
        integer_value <- as.integer(charToRaw(num)) - 48
        soma <- soma + (integer_value * multiplicador)
        multiplicador <- multiplicador - 1}
    soma <- soma + (dvs[1] * multiplicador)
    resto <- soma %% (num_algarismos_base + 2)
    if (resto > 1) {
        dvs[2] <- (num_algarismos_base + 2) - resto}
    dvs}

verificar <- function(cpf) {
    CPF <- reter_numeros(cpf, 11)
    digitos_recebidos <- c(
        as.integer(charToRaw(substr(CPF, 10, 10))) - 48,
        as.integer(charToRaw(substr(CPF, 11, 11))) - 48)
    digitos_calculados <- calcular_digitos_verificadores(substr(CPF, 1, 9))
    if (digitos_calculados[1] == digitos_recebidos[1] &&
        digitos_calculados[2] == digitos_recebidos[2]) {
        return(TRUE)}
    FALSE}

cat(sprintf('                   reter_numeros("test", 1) = "%s"\n',
    reter_numeros("test", 1)))
cat(sprintf('                  reter_numeros("test1", 1) = "%s"\n',
    reter_numeros("test1", 1)))
cat(sprintf('                  reter_numeros("test1", 2) = "%s"\n',
    reter_numeros("test1", 2)))
cat(sprintf('                 reter_numeros("test12", 2) = "%s"\n',
    reter_numeros("test12", 2)))

cat(sprintf('calcular_digitos_verificadores("987654321") = %s\n',
    toString(calcular_digitos_verificadores("987654321"))))
cat(sprintf('      calcular_digitos_verificadores("191") = %s\n',
    toString(calcular_digitos_verificadores("191"))))
cat(sprintf('      calcular_digitos_verificadores("192") = %s\n',
    toString(calcular_digitos_verificadores("192"))))
cat(sprintf('      calcular_digitos_verificadores("193") = %s\n',
    toString(calcular_digitos_verificadores("193"))))
cat(sprintf('      calcular_digitos_verificadores("123") = %s\n',
    toString(calcular_digitos_verificadores("123"))))

cat(sprintf('                             verificar("0") = %s\n',
    verificar("0")))
cat(sprintf('                         verificar("12359") = %s\n',
    verificar("12359")))
cat(sprintf('                         verificar("12360") = %s\n',
    verificar("12360")))
cat(sprintf('                         verificar("12361") = %s\n',
    verificar("12361")))
