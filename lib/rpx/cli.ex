defmodule Rpx.CLI do
  def main(args) do
    args |> parse_args |> run
  end

  defp run({args_config, [term, replacement], _}) do
    Rpx.run(args_config, term, replacement)
  end

  defp run(_) do
    IO.puts(
      """
      NAME
           rpx -- simple and powerfull string replacer

      SYNOPSIS
           rpx <string-to-be-replaced> <replacement> [-pxa]

      DESCRIPTION

           Rpx scans all allowed files recursively and shows all occurences of <string-to-be-replaced> in each file, then it
           asks for confirmation before replace all occurrences by <replacement>.

           The following options are available:

           --path | -p      The base path rpx will start analyzing recursively (default `.`).
           --ext | -x       The file extentions (comma separated) allowed to be analyzed (default see `~/.rpx.iex`).
           --all | -a       Replaces all found occurences without asking.
           --regex | -r     Treats the <string-to-be-replaced> as a regex instead of a simple text.
      """
    )
  end

  defp parse_args(args) do
    switches = [
      ext: :string,
      path: :string,
      all: :boolean,
      regex: :boolean
    ]

    aliases = [
      x: :ext,
      p: :path,
      a: :all,
      r: :regex
    ]

    OptionParser.parse(args, switches: switches, aliases: aliases)
  end
end
