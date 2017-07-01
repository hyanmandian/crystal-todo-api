require "kemal"
require "./entities/*"
require "./repositories/*"

module Routes
  get "/tasks" do |req|
    todo = Repositories::Todo.new()
    todo.all().to_json()
  end

  get "/tasks/:task" do |req|
    todo = Repositories::Todo.new()
    todo.find(req.params.url["task"]).to_json
  end

  post "/tasks" do |req|
    data = req.params.json

    if !data["description"]?
      next req.response.status_code = 400
    end
    
    todo = Repositories::Todo.new()

    description = data["description"].as(String)
    task = Entities::Task.new(description)

    todo.store(task)

    req.response.status_code = 201
    todo.find(task.id).to_json
  end

  put "/tasks/:task" do |req|
    data = req.params.json;

    todo = Repositories::Todo.new()
    task = todo.find(req.params.url["task"])

    if task.nil?
      next req.response.status_code = 400
    end

    task.description = data["description"].as(String) if data.has_key? "description"
    task.done = data["done"].as(Bool) if data.has_key? "done"
    todo.update(task.id, task)
  end

  delete "/tasks/:task" do |req|
    todo = Repositories::Todo.new()
    todo.delete(req.params.url["task"])
    req.response.status_code = 200
  end
  
  Kemal.config.port = ENV["PORT"]? ? ENV["PORT"].to_i32() : 1337
  Kemal.run
end