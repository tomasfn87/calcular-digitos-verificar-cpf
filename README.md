# calcular-digitos-verificar-cpf
Como calcular os dígitos verificadores de um CPF; em Python, Typescript e Go.

<br><br>

---

## Teste a versão em Go:

* [Calcular Digitos / Verificar CPF](https://onlinegdb.com/0W4euVwWW)

<br><br>

## Instale a ferramenta CLI com base na versão em Python via `git clone` em sistemas Linux

* É necessário ter privilégios de administrador;
* É necessário ter o `git` instalado.

<br>

### Instalação

```bash
sudo git clone --depth 1 https://github.com/tomasfn87/calcular-digitos-verificar-cpf /usr/local/lib/calcular-digitos-verificar-cpf && sudo mv /usr/local/lib/calcular-digitos-verificar-cpf/python/* /usr/local/lib/calcular-digitos-verificar-cpf && sudo chmod +x /usr/local/lib/calcular-digitos-verificar-cpf/*.sh && sudo ln -s /usr/local/lib/calcular-digitos-verificar-cpf/calcular_digitos_cpf.sh /usr/local/bin/cdcpf && sudo ln -s /usr/local/lib/calcular-digitos-verificar-cpf/verificar_cpf.sh /usr/local/bin/vcpf && sudo rm -rf /usr/local/lib/calcular-digitos-verificar-cpf/.git* /usr/local/lib/calcular-digitos-verificar-cpf/README.md /usr/local/lib/calcular-digitos-verificar-cpf/go /usr/local/lib/calcular-digitos-verificar-cpf/typescript /usr/local/lib/calcular-digitos-verificar-cpf/python /usr/local/lib/calcular-digitos-verificar-cpf/*-test.py && echo "\nUse os comandos vcpf e cdcpf para verificar ou calcular os dígitos de um CPF."
```

### Desinstalação


```bash
sudo rm -rf /usr/local/lib/calcular-digitos-verificar-cpf /usr/local/bin/vcpf /usr/local/bin/cdcpf
```

### Atualização

```bash
sudo rm -rf /usr/local/lib/calcular-digitos-verificar-cpf && sudo git clone --depth 1 https://github.com/tomasfn87/calcular-digitos-verificar-cpf /usr/local/lib/calcular-digitos-verificar-cpf && sudo mv /usr/local/lib/calcular-digitos-verificar-cpf/python/* /usr/local/lib/calcular-digitos-verificar-cpf && sudo chmod +x /usr/local/lib/calcular-digitos-verificar-cpf/*.sh && sudo rm -rf /usr/local/lib/calcular-digitos-verificar-cpf/.git* /usr/local/lib/calcular-digitos-verificar-cpf/README.md /usr/local/lib/calcular-digitos-verificar-cpf/go /usr/local/lib/calcular-digitos-verificar-cpf/typescript /usr/local/lib/calcular-digitos-verificar-cpf/python /usr/local/lib/calcular-digitos-verificar-cpf/*-test.py && echo "\nvcpf e cdcpf foram atualizados."
```

---

<br><br>

### Usos

* É necessário ter o `python3` instalado.

<br><br>

CPF inválido
```bash
vcpf 123.456.789-08
```

<br>

CPF válido
```bash
vcpf 123.456.789-09
```

<br>

Cálculo dos Dígitos verificadores de um CPF
```bash
cdcpf 123.456.789
```

<br>

Cálculo dos Dígitos verificadores de um CPF
```bash
cdcpf 123.456.789-09
```

> _Apenas os 9 primeiros dígitos são considerados_.
