# Verificar CPF

## Compilar

```console
cargo -q build
```

---

## Executar

### Calcular Dígitos Verificadores CPF

```console
./target/debug/main -c 987.654.321
./target/debug/main --calcular 123.456.789
```

---

### Verificar CPF

- *__válido__*

```console
./target/debug/main -v 987.654.321-00
./target/debug/main --verificar 987.654.321-00
```

- *__inválido__*

```console
./target/debug/main -v 123.456.789-00
./target/debug/main --verificar 123.456.789-00
```

---

### Demo _(funções do projeto)_

```console
./target/debug/main --demo
```
