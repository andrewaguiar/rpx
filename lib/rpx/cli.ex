defmodule Rpx.CLI do
  alias Rpx.Colors

  def main(args) do
    args |> parse_args |> validate_args |> run
  end

  defp validate_args(args = {_, [_, _], _}), do: args

  defp validate_args(args = {_, [_, _, base_path], _}) do
    if File.dir?(base_path) do
      args
    else
      IO.puts(
        """
        ERROR
            Invalid base_path #{Colors.red(base_path)}, should point to a valid directory
        """
      )

      :error
    end
  end

  defp validate_args(args), do: args

  defp run({args_config, [term, replacement], _}) do
    Rpx.run(args_config, term, replacement, ".")
  end

  defp run({args_config, [term, replacement, base_path], _}) do
    Rpx.run(args_config, term, replacement, base_path)
  end

  defp run(_) do
    IO.puts(
      """
      NAME
           rpx -- simple and powerfull string replacer

      SYNOPSIS
           rpx <string-to-be-replaced> <replacement> [base-path] [-xar]

      DESCRIPTION

           Rpx scans all allowed files recursively and shows all occurences of <string-to-be-replaced> in each file, then it
           asks for confirmation before replace all occurrences by <replacement>.

           The following options are available:

           --ext | -x       The file extentions (comma separated) allowed to be analyzed (default see `~/.rpx.iex`).
           --all | -a       Replaces all found occurences without asking.
           --regex | -r     Treats the <string-to-be-replaced> as a regex instead of a simple text.
      """
    )
  end

  defp parse_args(args) do
    switches = [
      ext: :string,
      all: :boolean,
      regex: :boolean
    ]

    aliases = [
      x: :ext,
      a: :all,
      r: :regex
    ]

    OptionParser.parse(args, switches: switches, aliases: aliases)
  end
end
