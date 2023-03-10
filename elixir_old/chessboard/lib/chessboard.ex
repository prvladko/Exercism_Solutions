defmodule Chessboard do
  def rank_range, do: 1..8
  def file_range, do: ?A..?H
  def ranks, do: Enum.to_list(rank_range())

  def files do
    file_range()
    |> Enum.to_list()
    |> Enum.map(fn f -> <<f::utf8>> end)
  end
end
