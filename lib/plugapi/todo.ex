defmodule Todo do
  use Ecto.Schema

  @type t :: %__MODULE__{
          description: String.t(),
          done: boolean()
        }

  schema "todo" do
    field(:description, :string)
    field(:done, :boolean)
  end

  defimpl Jason.Encoder do
    def encode(%Todo{description: desc, done: done}, opts) do
      Jason.Encode.map(%{description: desc, done: done}, opts)
    end
  end
end
