# Calcular Dígitos / Verificar CPF

```console
odin version dev-2024-01-nightly:5961d4b3
```

## Como usar

### Compilar

```console
odin build Cpf.odin -file
```

### Executar

#### Calcular Dígitos Verificadores

```console
./Cpf -c 123.456.789
./Cpf --calcular 987.654.321
```

#### Verificar

```console
./Cpf -v 123.456.789-00
./Cpf --verificar 987.654.321-00
```
