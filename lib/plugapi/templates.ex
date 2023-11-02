defmodule Plugapi.Templates do
  require EEx

  EEx.function_from_file(:def, :todo_created, "lib/templates/todo_created.eex", [:todo_name])
  EEx.function_from_file(:def, :todos, "lib/templates/todos.eex", [:todos])
end
