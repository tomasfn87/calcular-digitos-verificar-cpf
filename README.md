# calcular-digitos-verificar-cpf

_Como calcular os dígitos verificadores de um_ __CPF__; _em_ `Python`, `Typescript` e `Go`.

---

<br><br>

_Teste a versão em_ `Go`:
- [CPF - Calcular Digitos / Verificar](http://bit.ly/3UvUSTL)

<br><br>

## Instale a ferramenta CLI com base na versão em Python via `git clone` em sistemas `Linux`

- É necessário ter privilégios de __administrador__;
- É necessário ter o `git` instalado.

<br>

### _Instalação_

```shell
sudo git clone --depth 1 https://github.com/tomasfn87/calcular-digitos-verificar-cpf /usr/local/lib/calcular-digitos-verificar-cpf && sudo mv /usr/local/lib/calcular-digitos-verificar-cpf/python/* /usr/local/lib/calcular-digitos-verificar-cpf && sudo chmod +x /usr/local/lib/calcular-digitos-verificar-cpf/*.sh && sudo ln -rs /usr/local/lib/calcular-digitos-verificar-cpf/calcular_digitos_cpf.sh /usr/local/bin/cdcpf && sudo ln -rs /usr/local/lib/calcular-digitos-verificar-cpf/verificar_cpf.sh /usr/local/bin/vcpf && sudo rm -rf /usr/local/lib/calcular-digitos-verificar-cpf/{.git*,README.md,go,typescript,python,*-test.py} && echo "\nUse os comandos vcpf e cdcpf para verificar ou calcular os dígitos de um CPF."
```

### _Desinstalação_


```shell
sudo rm -rf /usr/local/{lib/calcular-digitos-verificar-cpf,bin/{cd,v}cpf}
```

### _Atualização_

```shell
sudo rm -rf /usr/local/lib/calcular-digitos-verificar-cpf && sudo git clone --depth 1 https://github.com/tomasfn87/calcular-digitos-verificar-cpf /usr/local/lib/calcular-digitos-verificar-cpf && sudo mv /usr/local/lib/calcular-digitos-verificar-cpf/python/* /usr/local/lib/calcular-digitos-verificar-cpf && sudo chmod +x /usr/local/lib/calcular-digitos-verificar-cpf/*.sh && sudo rm -rf /usr/local/lib/calcular-digitos-verificar-cpf/{.git*,README.md,go,typescript,python,*-test.py} && echo "\nvcpf e cdcpf foram atualizados."
```

---

<br><br>

### Usos

- É necessário ter o `python3` instalado.

<br><br>

*__CPF__* _inválido_:
```shell
vcpf 123.456.789-08
```

<br>

*__CPF__* _válido_:
```shell
vcpf 123.456.789-09
```

<br>

_Cálculo dos Dígitos verificadores de um_ *__CPF__*:
```shell
cdcpf 123.456.789
```

<br>

_Cálculo dos Dígitos verificadores de um_ *__CPF__*:
```shell
cdcpf 123.456.789-09
```

> _Apenas os_ *__9 primeiros dígitos__* _são considerados_.
