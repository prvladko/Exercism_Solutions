defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    cond do
    :math.sqrt(x * x + y * y) > 10 -> 0
    :math.sqrt(x * x + y * y) <= 10 and :math.sqrt(x * x + y * y) > 5 -> 1
    :math.sqrt(x * x + y * y) <= 5 and :math.sqrt(x * x + y * y) > 1 -> 5
    :math.sqrt(x * x + y * y) <= 1 -> 10
    end
  end
end
