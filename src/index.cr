require "kemal"
require "./entities/*"
require "./repositories/*"

module Routes
  get "/tasks" do
    todo = Repositories::Todo.new()
    todo.all().to_json
  end

  get "/tasks/:task" do |req|
    todo = Repositories::Todo.new()
    todo.find(req.params.url["task"]).to_json
  end

  post "/tasks" do |req|
    todo = Repositories::Todo.new()

    description = req.params.json["description"].as(String)
    task = Entities::Task.new(description, false)

    todo.store(task)
    todo.find(task.id).to_json
  end

  put "/tasks/:task" do |req|
    todo = Repositories::Todo.new()
    task = todo.find(req.params.url["task"])

    puts req.params.json

    description = req.params.json["description"].as(String)

    if description
      task.description = description
    end

    done = req.params.json["done"].as(Bool)

    if done 
      task.done = done
    end

    todo.update(task)

    "OK!"
  end

  delete "/tasks/:task" do |req|
    todo = Repositories::Todo.new()
    todo.delete(req.params.url["task"])

    "OK!"
  end
  
  Kemal.config.port = 1337
  Kemal.run
end