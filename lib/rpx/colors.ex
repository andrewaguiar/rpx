defmodule Rpx.Colors do
  def green(text) do
    "\e[1;32m#{text}\e[0m"
  end

  def blue(text) do
    "\e[1;36m#{text}\e[0m"
  end

  def red(text) do
    "\e[1;31m#{text}\e[0m"
  end

  def pink(text) do
    "\e[1;35m#{text}\e[0m"
  end

  def yellow(text) do
    "\e[1;33m#{text}\e[0m"
  end
end
