defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class(), do: Enum.random(@planetary_classes)
  def random_ship_registry_number(), do: "NCC-#{Enum.random(1000..9999)}"
  def random_stardate(), do: Enum.random(41000..41999) + :rand.uniform()
  def format_stardate(stardate), do: to_string(:io_lib.format("~10.1f", [stardate])) |> String.trim()
end
