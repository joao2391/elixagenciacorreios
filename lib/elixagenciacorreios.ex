defmodule Elixagenciacorreios do
  @moduledoc """
  Documentation for `Elixagenciacorreios`.
  """

  alias Elixagenciacorreios.Agencia

  #&nbsp
  @doc """
  Retorna agencias dos Correios filtrada por UF, Municiopio e Bairro.
  """
  def get_agencias(uf, municipio, bairro) do
    case HTTPoison.get("https://mais.correios.com.br/app/carrega/carrega_agencia_localidade.php?cmbEstado=#{uf}&cmbMunicipio=#{municipio}&cmbBairro=#{bairro}",
                        %{"User-Agent" => "elixagencias/1.0.1"}) do
      {:ok, %{body: raw_body, status_code: code}} -> {code, raw_body}
      html = raw_body
      {:ok, document} = Floki.parse_document(html)

      lista =
        document
        |> Floki.find("tbody")
        |> Floki.find(".tr-base")
        |> Floki.find(".agencia_desc")

        lista_enderecos = get_enderecos_agencia(lista)
        lista_situacoes = get_situacoes_agencia(lista)
        lista_nomes = get_nomes_agencia(lista)

        tamanho_lista = length(lista_enderecos)

        for x <- 0..tamanho_lista - 1 do
          endereco = lista_enderecos |> Enum.at(x)
          situacao = lista_situacoes |> Enum.at(x)
          nome = lista_nomes |> Enum.at(x)

          %Agencia{nome: nome, endereco: endereco, situacao: situacao}
        end

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

  defp get_enderecos_agencia(list) do

    list
    |> Enum.map(fn {_chave, _valor1, valor2} -> valor2
                  |> Floki.find(".endereco-agencia") |> Floki.text() end)

  end

  defp get_situacoes_agencia(list) do

    list
    |> Enum.map(fn {_chave, _valor1, valor2} -> valor2
                  |> Floki.find(".situacao-agencia") |> Floki.text() end)

  end

  defp get_nomes_agencia(list) do

    list
    |> Enum.map(fn {_chave, _valor1, valor2} -> valor2
                  |> Floki.find(".nome-agencia") |> Floki.text() end)

  end

end
