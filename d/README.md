# CPF - Cálculo dígitos verificadores / Verificação

## Como usar

### Compilar

```console
dub build
```

### Executar

#### Calcular Dígitos

```console
./cpf -c 123.456.789
./cpf --calcular 123.456.789
```

#### Verificar

```console
./cpf -v 123.456.789-08
./cpf --verificar 123.456.789-09
```

#### Formatar

```console
./cpf -f 123.456.789-08
./cpf --formatar 123.456.789-09
```
