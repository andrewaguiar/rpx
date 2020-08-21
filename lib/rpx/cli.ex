defmodule Rpx.CLI do
  alias Rpx.Colors

  def main(args) do
    args |> parse_args |> run
  end

  defp run({args_config, [term, replacement], []}) do
    Rpx.run(args_config, term, replacement)
  end

  defp run(_) do
    IO.puts(
      """
      #{Colors.bold("NAME")}
             rpx -- simple and powerfull string replacer based on non gitignore files

      #{Colors.bold("SYNOPSIS")}
             rpx <string-to-be-replaced> <replacement> [base-path] [-r]

      #{Colors.bold("DESCRIPTION")}

             Rpx scans all git ls-files recursively and shows all occurences of <string-to-be-replaced> in each file, then it
             asks for confirmation before replace all occurrences by <replacement>.

             The following options are available:

             #{Colors.bold("--regex | -r")}
                    Treats the <string-to-be-replaced> as a regex instead of a simple text (default false).
      """
    )
  end

  defp parse_args(args) do
    switches = [regex: :boolean]
    aliases = [r: :regex]

    OptionParser.parse(args, switches: switches, aliases: aliases)
  end
end
