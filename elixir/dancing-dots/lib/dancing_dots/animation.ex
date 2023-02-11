defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer
  @callback init(opts :: opts) :: {:ok, x :: opts} | {:error, x :: error}
  @callback handle_frame(a :: dot, b :: frame_number, c :: opts) :: dot

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation
      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation
  @impl DancingDots.Animation
  def handle_frame(%DancingDots.Dot{opacity: x} = dot, frame_number, _) do
    if rem(frame_number,4)==0, do:  %{dot | opacity: x/2},  else:  dot
  end
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation
  @impl DancingDots.Animation
  def init(opts) do
    if is_number(Keyword.get(opts, :velocity)) do {:ok, opts}
    else {:error, "The :velocity option is required, and its value must be a number. Got: #{inspect(Keyword.get(opts, :velocity))}"}
    end
  end
  @impl DancingDots.Animation
  def handle_frame(%DancingDots.Dot{radius: x} = dot , frame_number, opts) do
    velocity = Keyword.get(opts, :velocity)
    %{dot | radius: x + (frame_number-1)*velocity}
  end
end
