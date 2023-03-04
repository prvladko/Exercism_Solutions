defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    hourly_rate * 8.0
  end

  def apply_discount(before_discount, discount) do
    before_discount - before_discount * discount / 100
    # |> Float.round(5)
  end

  def monthly_rate(hourly_rate, discount) do
    monthly = daily_rate(hourly_rate) * 22
    # trunc(Float.ceil(monthly - monthly * discount / 100))
    # apply_discount(monthly, discount) |> Float.ceil(0) |> trunc
    trunc(Float.ceil(apply_discount(monthly, discount)))
  end

  def days_in_budget(budget, hourly_rate, discount) do
    # Float.floor(budget / (monthly_rate(hourly_rate, discount) / 22), 1)
    daily_rate_cd = daily_rate(hourly_rate)
    trunc(budget/apply_discount(daily_rate_cd, discount)*10)/10
  end
end
