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
    task = Entities::Task.new(description)

    todo.store(task)
    todo.find(task.id).to_json
  end

  put "/tasks/:task" do |req|
    data = req.params.json;

    todo = Repositories::Todo.new()

    task = todo.find(req.params.url["task"])

    if task.nil?
      next "404!"
    end

    task.description = data["description"].as(String) if data.has_key? "description"
    task.done = data["done"].as(Bool) if data.has_key? "done"
    todo.update(task)

    "OK!"
  end

  delete "/tasks/:task" do |req|
    todo = Repositories::Todo.new()
    todo.delete(req.params.url["task"])

    "OK!"
  end
  
  Kemal.config.port = ENV["PORT"] || 1337
  Kemal.run
end