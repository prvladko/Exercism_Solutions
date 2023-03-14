defmodule RecursionPractice do
  # def hello_world(count \\ 0) do
  #   IO.puts("Hello, World!")
  #   if count < 10 do
  #     new_count = count + 1
  #     hello_world(new_count)
  #   end
  # end

  def hello_world(count \\ 0)
  def hello_world(count) when count >= 3, do: nil

  def hello_world(count) do
    IO.puts("Hello, World!")
    new_count = count + 1
    hello_world(new_count)
  end
end
