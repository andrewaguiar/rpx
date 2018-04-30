defmodule Rpx.Searcher do
  def find(base_path, args_config, global_config) do
    deep_find_files(base_path, args_config, global_config) |> List.flatten
  end

  defp deep_find_files(base, args_config, global_config) do
    base
      |> File.ls!
      |> Enum.map(fn file ->
        file_path = "#{base}/#{file}"

        check(file_path, args_config, global_config, %{
          folder: File.dir?(file_path),
          ignored_folder: Enum.member?(global_config.ignored_folders, file),
          allowed_extention: allowed_extention?(file, args_config, global_config)
        })
      end)
  end

  defp check(_, _, _, %{folder: true, ignored_folder: true}), do: []

  defp check(_, _, _, %{folder: false, allowed_extention: false}), do: []

  defp check(file_path, args_config, global_config, %{folder: true, ignored_folder: false}) do
    deep_find_files(file_path, args_config, global_config)
  end

  defp check(file_path, _, _, %{folder: false, allowed_extention: true}) do
    file_path
  end

  defp allowed_extention?(file, args_config, global_config) do
    file_ext = file |> String.split(".") |> List.last

    exts = if args_config[:ext], do: String.split(args_config[:ext], ","), else: global_config.allowed_extentions
    exts |> Enum.member?(file_ext)
  end
end
