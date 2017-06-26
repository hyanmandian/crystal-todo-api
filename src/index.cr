require "kemal"
require "./entities/*"
require "./repositories/*"

module Routes
  get "/" do
    task = Entities::Task.new("Teste", false)
    todo = Repositories::Todo.new()
    todo.add(task)

    todo.all()
  end
  
  Kemal.config.port = 1337
  Kemal.run
end