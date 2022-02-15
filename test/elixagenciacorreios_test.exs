defmodule ElixagenciacorreiosTest do
  use ExUnit.Case
  doctest Elixagenciacorreios

  test "retorna 03 agencias" do
    assert length(Elixagenciacorreios.get_agencias("am","manaus","centro")) === 3
  end

  test "retorna 01 agencia" do
    assert length(Elixagenciacorreios.get_agencias("sp","aparecida","centro")) === 1
  end

end
