# CPF - Cálculo dígitos verificadores / Verificação

## Como usar

### Compilar

```shell
ghc -o cpf cpf.hs
```

### Executar

#### Cálculo Dígitos Verificadores

```shell
./cpf -c 123.456.789-XX
./cpf --calcular 123.456.789-XX
```

#### Formatação

```shell
./cpf -f 123.456.789-XX
./cpf --formatar 123.456.789-XX
```

#### Verificação

```shell
./cpf -v 123.456.789-09
./cpf --verificar 123.456.789-90
```

#### Demonstração

```shell
./cpf --demo
```