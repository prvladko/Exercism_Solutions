defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do

   defexception message: "stack underflow occurred"
    @impl true

    def exception(message) do
      case message do
        [] -> %StackUnderflowError{}
        _ -> %StackUnderflowError{message: "stack underflow occurred, context: #{message}"}
      end
    end
  end

  def divide(numbers) when length(numbers) < 2, do: raise StackUnderflowError, "when dividing"
  def divide([0, _]), do: raise DivisionByZeroError
  def divide([left, right]), do: right / left
end
