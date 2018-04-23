defmodule Rpx.ConditionsParser do
  def parse(conditions) do
    conditions
      |> String.trim
      |> String.split(",")
      |> Enum.map(&parse_token/1)
      |> List.flatten
  end

  defp parse_token("a"), do: "a"

  defp parse_token(token) do
    if token =~ ".." do
      [n1, nl] = token |> String.split("..") |> Enum.map(&String.to_integer/1)
      Range.new(n1, nl) |> Enum.to_list
    else
      String.to_integer(token)
    end
  end
end
