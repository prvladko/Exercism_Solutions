defmodule FreelancerRates do
  def daily_rate(hourly_rate), do: hourly_rate * 8.0

  def apply_discount(before_discount, discount), do: before_discount * (1.0 - discount/100.0)

  def monthly_rate(hourly_rate, discount) do
    hourly_rate * 22.0
    |> daily_rate
    |> apply_discount(discount)
    |> Kernel.ceil
  end

  def days_in_budget(budget, hourly_rate, discount) do
    discounted_rate = hourly_rate
    |> daily_rate
    |> apply_discount(discount)
    budget / discounted_rate
    |> Float.floor(1)
  end
end
