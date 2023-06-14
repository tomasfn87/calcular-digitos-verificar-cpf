# Calcular Dígitos / Verificar CPF

## Compilador

- *__`mcs`__*: `Mono C# compiler version 6.8.0.105`
- *__`mono`__*: `Mono JIT compiler version 6.8.0.105 (Debian 6.8.0.105+dfsg-3.2 Wed Jun 30 05:34:49 UTC 2021)`

## Como usar

### Compilar

```console
mcs -out:cpf.exe Cpf.cs
```

### Calcular Dígitos CPF

```console
mono cpf.exe -c 123.456.789
mono cpf.exe --calcular 123.456.789
```

---

### Verificar CPF

- *__válido__*

```console
mono cpf.exe -v 987.654.321-00
mono cpf.exe --verificar 987.654.321-00
```

- *__inválido__*

```console
mono cpf.exe -v 987.654.321-12
mono cpf.exe --verificar 987.654.321-12
```
