defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    hourly_rate * 8.0
  end

  def apply_discount(before_discount, discount) do
    before_discount - before_discount * discount / 100
  end

  def monthly_rate(hourly_rate, discount) do
    monthly = daily_rate(hourly_rate) * 22
    Kernel.trunc(Float.ceil(monthly - apply_discount(monthly, discount)))
  end

  def days_in_budget(budget, hourly_rate, discount) do
    Float.floor(budget / (monthly_rate(hourly_rate, discount) / 22), 1)
  end
end
