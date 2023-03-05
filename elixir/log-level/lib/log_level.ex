defmodule LogLevel do
  def to_label(level, legacy?) do
    cond do
      level == 0 and legacy? == false -> :trace
      level == 0 and legacy? == true -> :unknown
      level == 1 and legacy? == true -> :debug
      level == 1 and legacy? == false -> :debug
      level == 2 and legacy? == true -> :info
      level == 2 and legacy? == false -> :info
      level == 3 and legacy? == true -> :warning
      level == 3 and legacy? == false -> :warning
      level == 4 and legacy? == true -> :error
      level == 4 and legacy? == false -> :error
      level == 5 and legacy? == false -> :fatal
      level == 5 and legacy? == true -> :unknown
      (level > 5 or level < 0) and (legacy? == true or legacy? == false) -> :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    cond do
      level == 0 and legacy? == false -> :false
      level == 0 and legacy? == true -> :dev1
      level == 1 and legacy? == true -> :false
      level == 1 and legacy? == false -> :false
      level == 2 and legacy? == true -> :false
      level == 2 and legacy? == false -> :false
      level == 3 and legacy? == true -> :false
      level == 3 and legacy? == false -> :false
      level == 4 and legacy? == true -> :ops
      level == 4 and legacy? == false -> :ops
      level == 5 and legacy? == false -> :ops
      level == 5 and legacy? == true -> :dev1
      (level > 5 or level < 0) and (legacy? == true) -> :dev1
      (level > 5 or level < 0) and (legacy? == false) -> :dev2
    end
  end
end
