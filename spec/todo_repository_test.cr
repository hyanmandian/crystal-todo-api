require "./spec_helper"

def with_todo()
  todo = Repositories::Todo.new("test.db")
  yield todo
  todo.clear()
end

describe "TodoRepositoryTest" do
  describe "#store" do
    it "should save a task" do
      with_todo() do |todo|
        task = Entities::Task.new("test")
        todo.store(task)
        task_found = todo.find(task.id)

        task_found.to_json().should(eq(task.to_json()))
      end
    end
  end

  describe "#edit" do
    it "should edit a task" do
      with_todo() do |todo|
        task = Entities::Task.new("test")
        todo.store(task)
        task_found = todo.find(task.id)

        if (task_found.nil?)
          next
        end
      
        task_found.description = "tset"
        todo.update(task_found)
        task_updated = todo.find(task_found.id)

        task_updated.to_json().should(eq(task_found.to_json()))
      end
    end
  end

  describe "#delete" do
    it "should delete a task" do
      with_todo() do |todo|
        task = Entities::Task.new("test")
        todo.store(task)
        task_found = todo.find(task.id)
        todo.delete(task.id)
        task_deleted = todo.find(task.id)
        task_deleted.nil?.should(be_true())
      end
    end
  end

  describe "#find" do
    it "should find a task" do
      with_todo() do |todo|
        task = Entities::Task.new("test")
        todo.store(task)
        task_found = todo.find(task.id)
        task_found.to_json().should(eq(task.to_json()))
      end
    end
  end

  describe "#all" do
    it "should find all tasks" do
      with_todo() do |todo|
        task = Entities::Task.new("test")
        todo.store(task)
        tasks = todo.all()

        tasks.should(be_a(Array(Entities::Task)))
      end
    end
  end
end
