defmodule Rpx.Searcher do
  def find() do
    System.cmd("git", ["ls-files"])
    |> handle
  end

  defp handle({result, 0}) do
    result
    |> String.split("\n")
    |> Enum.reject(fn s -> s == "" end)
  end

  defp handle({"", 128}) do
    IO.puts("PWD is not a git controlled folder")

    System.halt(1)
  end

  defp handle({_, 1}) do
    IO.puts("git ls-files command not found")

    System.halt(1)
  end
end
