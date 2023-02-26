defmodule Lasagna do

  def expected_minutes_in_oven() do
    40
  end

  def remaining_minutes_in_oven(been) do
    expected_minutes_in_oven() - been
  end

  def preparation_time_in_minutes(layers) do
    2 * layers
  end

  def total_time_in_minutes(layers, been) do
    preparation_time_in_minutes(layers) + been
  end

  def alarm() do
    "Ding!"
  end
end
