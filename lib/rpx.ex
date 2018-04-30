defmodule Rpx do
  alias Rpx.Colors
  alias Rpx.ConditionsParser
  alias Rpx.GlobalConfig
  alias Rpx.Replacer
  alias Rpx.Scanner
  alias Rpx.Summarizer
  alias Rpx.Searcher

  def run(args_config, term_string, replacement) do
    term = %Rpx.Term{value: term_string, regex: args_config[:regex] != nil}

    global_config = GlobalConfig.read(:default)

    all_files = Searcher.find(args_config, global_config)

    matched_lines = Scanner.generate(all_files, term)

    Scanner.print(matched_lines, term)

    Summarizer.print(matched_lines, args_config, global_config)

    run_replacer(matched_lines, term, replacement, args_config[:all])
  end

  defp run_replacer([], _, _, _) do
    IO.puts("No occurrences found")
  end

  defp run_replacer(matched_lines, term, replacement, true) do
    Replacer.run(matched_lines, term, replacement, ["a"])
  end

  defp run_replacer(matched_lines, term, replacement, _) do
    IO.puts("Instructions:")
    IO.puts("  Type an \"#{Colors.green("a")}\" to replace all.")
    IO.puts("  Type a single #{Colors.yellow("ID")} number to replace only that line. example #{Colors.yellow("1")}")
    IO.puts("  Type a set of #{Colors.yellow("IDs")} separated by comma, example: #{Colors.yellow("1,2,3")}.")
    IO.puts("  Type a range using .. to replace a range of IDs, example: #{Colors.yellow("3..5")}")
    IO.puts("  Conbine #{Colors.yellow("IDs")} and Ranges freely. example: #{Colors.yellow("1,2,3,10..12,20..25")}")
    IO.puts("  Type nothing and press Enter to abort\n")

    case IO.gets("Which lines do you want to replace? ") do
      "\n" ->
        IO.puts("\nAborting!")

      conditions ->
        IO.puts("")

        parsed_conditions = ConditionsParser.parse(conditions)
        Replacer.run(matched_lines, term, replacement, parsed_conditions)
    end
  end
end
