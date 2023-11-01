defmodule Todo do
  defstruct description: "", done: false

  defimpl Jason.Encoder do
    def encode(%Todo{description: desc, done: done}, opts) do
      Jason.Encode.map(%{description: desc, done: done}, opts)
    end
  end
end
