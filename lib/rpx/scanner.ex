defmodule Rpx.Scanner do
  alias Rpx.Colors
  alias Rpx.Term

  def generate(files, term) do
    files
      |> Enum.map(fn file ->
        file
          |> File.read!
          |> String.split("\n")
          |> Enum.with_index(1)
          |> Enum.filter(fn {line, _index} -> Term.match?(term,  line) end)
          |> Enum.map(fn {line, index} -> {file, line, index} end)
      end)
      |> List.flatten
      |> Enum.with_index(1)
      |> Enum.map(fn {{file, line, index}, id} -> {id, file, line, index} end)
  end

  def print(matched_lines, term) do
    IO.puts("#{Colors.yellow("ID")} :: #{Colors.green("FILE")}:#{Colors.blue("LINE")} -> TEXT WITH THE #{Colors.red("TERM")}\n")

    matched_lines
      |> Enum.each(fn {id, file, line, index} ->
        around_text = highlight(format_line(line, term), term)
        IO.puts("#{Colors.yellow(id)} :: #{Colors.green(file)}:#{Colors.blue(index)} -> #{around_text}")
      end)
  end

  defp highlight(line, term) do
    Term.highlight(term, line)
  end

  defp format_line(line, term) do
    if String.length(line) > 77 do
      {index, matched_size} = Term.match(term, line)

      starting = if index - 30 >= 0, do: (index - 30), else: 0
      ending = index + matched_size + 29

      "...#{String.slice(line, starting..ending)}..."
    else
      line
    end
  end
end
