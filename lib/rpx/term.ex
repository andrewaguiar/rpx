defmodule Rpx.Term do
  alias Rpx.Colors

  defstruct [:value, :regex]

  def match?(%Rpx.Term{value: term_string, regex: false}, line) do
    line =~ term_string
  end

  def match?(%Rpx.Term{value: term_string, regex: true}, line) do
    term_string |> Regex.compile! |> Regex.match?(line)
  end

  def highlight(%Rpx.Term{value: term_string, regex: false}, line) do
    String.replace(line, term_string, Colors.red(term_string))
  end

  def highlight(%Rpx.Term{value: term_string, regex: true}, line) do
    term_string |> Regex.compile! |> Regex.replace(line, fn x -> Colors.red(x) end)
  end

  def match(%Rpx.Term{value: term_string, regex: false}, line) do
    :binary.match(line, term_string)
  end

  def match(%Rpx.Term{value: term_string, regex: true}, line) do
    result_term = term_string |> Regex.compile! |> Regex.run(line)

    :binary.match(line, result_term)
  end

  def replace(%Rpx.Term{value: term_string, regex: false}, line, replacement) do
    String.replace(line, term_string, replacement, global: true)
  end

  def replace(%Rpx.Term{value: term_string, regex: true}, line, replacement) do
    String.replace(line, term_string, replacement, global: true)

    term_string |> Regex.compile! |> Regex.replace(line, replacement)
  end
end
