# Verificar CPF

## Compilar

```shell
cargo -q build
```

## Executar

### Verificar CPF

- *__válido__*

```shell
cargo -q run 123.456.789-09
```

- *__inválido__*

```shell
cargo -q run 123.456.789-10
```

### Demo _(funções do projeto)_

```shell
cargo -q run demo
```
