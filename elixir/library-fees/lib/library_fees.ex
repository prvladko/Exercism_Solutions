defmodule LibraryFees do

  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    datetime
    |> NaiveDateTime.to_time()
    |> Time.compare(~T[12:00:00])
    |> Kernel.==(:lt)
  end

  def return_date(checkout_datetime) do
    checkout_datetime
    |> before_noon?()
    |> do_return_date(checkout_datetime)
  end

  defp do_return_date(false, checkout_datetime) do
    NaiveDateTime.to_date(checkout_datetime)
    |> Date.add(29)
  end

  defp do_return_date(true, checkout_datetime) do
    NaiveDateTime.to_date(checkout_datetime)
    |> Date.add(28)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    late_days =
      NaiveDateTime.to_date(actual_return_datetime)
      |> Date.diff(planned_return_date)
    if late_days < 0, do: 0, else: late_days
  end

  def monday?(datetime) do
    NaiveDateTime.to_date(datetime)
    |> Date.day_of_week()
    |> Kernel.==(1)
  end

  def calculate_late_fee(checkout, return, rate) when is_binary(checkout) and is_binary(return) do
    calculate_late_fee(datetime_from_string(checkout), datetime_from_string(return), rate)
  end

  def calculate_late_fee(checkout, return, rate) do
    fee =
      return_date(checkout)
      |> days_late(return)
      |> Kernel.*(rate)
    if monday?(return), do: Integer.floor_div(fee, 2), else: fee
  end
end
