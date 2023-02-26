defmodule BasketballWebsite do

  def extract_from_path(data, path) do
    keys = String.split(path, ".")
    extract_from_keys(data, keys)
  end

  defp extract_from_keys(data, []), do: data

  defp extract_from_keys(data, [key|rest]) do
    case data[key] do
      nil -> nil
      data -> extract_from_keys(data, rest)
    end
  end

  def get_in_path(data, path) do
    get_in(data, String.split(path, "."))
  end
end
