defmodule Rpx.Replacer do
  alias Rpx.Term

  def run(matched_lines, term, replacement, conditions) do
    matched_lines
      |> Enum.filter(fn {id, _, _, _} -> apply_replacement?(id, conditions) end)
      |> Enum.group_by(fn {_, file, _, _} -> file end)
      |> Enum.each(fn {file, file_matched_lines} ->
        lines_to_be_replaced = file_matched_lines
          |> Enum.map(fn {_, _, _, index} -> index end)

        new_content = file
          |> File.read!
          |> String.split("\n")
          |> Enum.with_index(1)
          |> Enum.map(fn {line, index} ->
            if Enum.member?(lines_to_be_replaced, index) do
              Term.replace(term, line, replacement)
            else
              line
            end
          end)
          |> Enum.join("\n")

        File.write!(file, new_content)
      end)

    IO.puts("Done")
  end

  defp apply_replacement?(id, conditions) do
    Enum.member?(conditions, "a") || Enum.member?(conditions, id)
  end
end
