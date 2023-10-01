defmodule CPF do
  def reter_numeros(texto, n) when is_binary(texto) and is_integer(n) do
    apenas_nums = String.replace(texto, ~r/[^0-9]/, "")
    numeros_encontrados = String.slice(apenas_nums, 0, n)

    case String.length(numeros_encontrados) do
      0 ->
        {:ok, ""}

      len when len < n ->
        zeros_faltando = String.duplicate("0", n - len)
        {:ok, zeros_faltando <> numeros_encontrados}

      _ ->
        {:ok, numeros_encontrados}
    end
  end

  def calcular_digitos_verificadores(cpf) when is_binary(cpf) do
    apenas_numeros = elem(CPF.reter_numeros(cpf, 9), 1)

    if String.length(apenas_numeros) < 1 do
      {:error, False}
    else
      primeiro_digito = calcular_digito_verificador(apenas_numeros)

      segundo_digito =
        calcular_digito_verificador(apenas_numeros <> Integer.to_string(primeiro_digito))

      {:ok, [primeiro_digito, segundo_digito]}
    end
  end

  def calcular_digito_verificador(cpf) when is_binary(cpf) do
    numeros = String.to_charlist(cpf)
    numeros_integer = Enum.map(numeros, fn char -> char - ?0 end)
    multiplicadores = for n <- (length(numeros_integer) + 1)..2, do: n

    soma =
      Enum.reduce(Enum.zip(numeros_integer, multiplicadores), 0, fn {num, mult}, acc ->
        num * mult + acc
      end)

    digito_verificador = if rem(soma, 11) < 2, do: 0, else: 11 - rem(soma, 11)
    digito_verificador
  end
end

# --demo
IO.puts(
  "                  reter_numeros(\"123\", 9) = \"#{elem(CPF.reter_numeros("123", 9), 1)}\""
)

IO.puts(
  "               reter_numeros(\"456789\", 9) = \"#{elem(CPF.reter_numeros("456789", 9), 1)}\""
)

IO.write("   calcular_digitos_verificadores(\"test\") = ")
IO.inspect(elem(CPF.calcular_digitos_verificadores("test"), 1))

IO.write("   calcular_digitos_verificadores(\"0\")    = ")
IO.inspect(elem(CPF.calcular_digitos_verificadores("0"), 1))

IO.write(" calcular_digitos_verificadores(\"191\")    = ")
IO.inspect(elem(CPF.calcular_digitos_verificadores("191"), 1))

IO.write(" calcular_digitos_verificadores(\"192\")    = ")
IO.inspect(elem(CPF.calcular_digitos_verificadores("192"), 1))

IO.write(" calcular_digitos_verificadores(\"193\")    = ")
IO.inspect(elem(CPF.calcular_digitos_verificadores("193"), 1))

IO.write(" calcular_digitos_verificadores(\"123\")    = ")
IO.inspect(elem(CPF.calcular_digitos_verificadores("123"), 1))
