# CPF - Cálculo dígitos verificadores / Verificação

## Como usar

### Compilar

```console
zig build-exe cpf.zig
```

### Executar

#### Calcular Dígitos

```console
./cpf -c 123.456.789-XX
./cpf --calcular 123.456.789-XX
```

#### Verificar

```console
./cpf -v 123.456.789-08
./cpf --verificar 123.456.789-09
```
