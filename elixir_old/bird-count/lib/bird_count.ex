defmodule BirdCount do
  def today([]), do: nil
  def today(list), do: hd list
  def increment_day_count([]), do: [1]

  def increment_day_count([today|other_days]) do
    [today + 1|other_days]
  end

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([current_day_count|other_days]) when current_day_count == 0, do: true
  def has_day_without_birds?([_current_day_count|other_days]), do: has_day_without_birds?(other_days)
  def total(list, acc \\ 0)
  def total([], acc), do: acc
  def total([current_day_count|other_days], acc), do: total(other_days, acc + current_day_count)
  def busy_days(list, acc \\ 0)
  def busy_days([], acc), do: acc

  def busy_days([current_day_count|other_days], acc) do
     if current_day_count >= 5 do
       busy_days(other_days, acc + 1)
     else
       busy_days(other_days, acc)
     end
  end
end
