# Calcular Dígitos / Verificar CPF

## Calcular Dígitos CPF

```shell
go run cmd/main.go c 123.456.789
```

---

## Verificar CPF

- *__válido__*

```shell
go run cmd/main.go v 123.456.789-09
```

- *__inválido__*

```shell
go run cmd/main.go v 123.456.789-00
```
