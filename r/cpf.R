reter_numeros <- function(texto, n) {
    apenas_nums <- ""
    cont <- 0
    for (char in strsplit(texto, NULL)[[1]]) {
        if (cont == n) {
            break
        }
        char_code <- as.integer(charToRaw(char))
        if (char_code > 47 && char_code < 58) {
            apenas_nums <- paste0(apenas_nums, char)
            cont <- cont + 1
        }
    }
    if (cont == 0) {
        return("")
    }
    while (nchar(apenas_nums) < n) {
        apenas_nums <- paste0("0", apenas_nums)
    }
    apenas_nums
}

cat(sprintf('reter_numeros("test", 1) = "%s"\n', reter_numeros("test", 1)))
cat(sprintf('reter_numeros("test1", 1) = "%s"\n', reter_numeros("test1", 1)))
cat(sprintf('reter_numeros("test1", 2) = "%s"\n', reter_numeros("test1", 2)))
cat(sprintf('reter_numeros("test12", 2) = "%s"\n', reter_numeros("test12", 2)))
