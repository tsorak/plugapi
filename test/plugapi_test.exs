defmodule PlugapiTest do
  use ExUnit.Case
  doctest Plugapi

  test "greets the world" do
    assert Plugapi.hello() == :world
  end
end
