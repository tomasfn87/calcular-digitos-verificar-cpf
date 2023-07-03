# Calcular Dígitos / Verificar CPF

## Como usar

### Calcular Dígitos CPF

```shell
ruby cpf.rb -c 123.456.789
ruby cpf.rb --calcular 123.456.789
```

---

### Verificar CPF

- *__válido__*

```shell
ruby cpf.rb -v 123.456.789-09
ruby cpf.rb --verificar 123.456.789-09
```

- *__inválido__*

```shell
ruby cpf.rb -v 123.456.789-19
ruby cpf.rb --verificar 123.456.789-19
```

---

### Demo

```shell
ruby cpf.rb --demo
```
