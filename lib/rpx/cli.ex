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
      #{Colors.bold("NAME")}
             rpx -- simple and powerfull string replacer

      #{Colors.bold("SYNOPSIS")}
             rpx <string-to-be-replaced> <replacement> [base-path] [-xar]

      #{Colors.bold("DESCRIPTION")}

             Rpx scans all allowed files recursively and shows all occurences of <string-to-be-replaced> in each file, then it
             asks for confirmation before replace all occurrences by <replacement>.

             The following options are available:

             #{Colors.bold("--ext | -x")}
                    The file extentions (comma separated) allowed to be analyzed (default see `~/.rpx.iex`).

             #{Colors.bold("--all | -a")}
                    Replaces all found occurences without asking.

             #{Colors.bold("--regex | -r")}
                    Treats the <string-to-be-replaced> as a regex instead of a simple text (default false).

             #{Colors.bold("--profile | -p")}
                    Uses an specific profile configured in ~/.rpx.exs (default :default).

      #{Colors.bold("PROFILES")}
             First time you run Rpx it will create the global config file in HOME called ~/.rpx.exs,
             Rpx uses this global configuration file named ~/.rpx.exs to configure 2 basic stuff.

             1. The allowed extentions and.
             2. Ignored folders during the scan.

             When you don't pass --profile|-p argument it with use the :default profile defined in ~/.rpx.exs,
             You can as many different profiles you want in the ~/.rpx.exs file as a ordinary elixir code (a Map structure)
             following the template:

                    profile_name: %{
                      allowed_extentions: List,
                      ignored_folders: List
                    }

             Or you can simply modify the default profile :default =)
      """
    )
  end

  defp parse_args(args) do
    switches = [
      ext: :string,
      all: :boolean,
      regex: :boolean,
      profile: :string
    ]

    aliases = [
      x: :ext,
      a: :all,
      r: :regex,
      p: :profile
    ]

    OptionParser.parse(args, switches: switches, aliases: aliases)
  end
end
