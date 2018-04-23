defmodule Rpx.Summarizer do
  alias Rpx.Colors

  def print(matched_lines, args_config, global_config) do
    total_lines = matched_lines
      |> length

    total_files = matched_lines
      |> Enum.map(fn {_, file, _, _} -> file end)
      |> Enum.uniq
      |> length

    base_path = args_config[:path] || "."
    ext = args_config[:ext] || (global_config.allowed_extentions |> Enum.join(", "))

    IO.puts(
      "\n#{Colors.green(total_files)} files and #{Colors.green(total_lines)} " <>
      "lines found in #{Colors.green(base_path)} with the extentions #{Colors.green(ext)}\n"
    )
  end
end
