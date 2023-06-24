# CPF - Cálculo dígitos verificadores / Verificação

## Como usar

### Compilar

```console
gcc cpf.c -o cpf
```

### Executar

#### Cálculo Dígitos Verificadores

```console
./cpf -c 123.456.789-XX
./cpf --calcular 123.456.789-XX
```

#### Verificação

```console
./cpf -v 123.456.789-09
./cpf --verificar 123.456.789-90
```
