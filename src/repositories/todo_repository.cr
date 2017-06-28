require "nuummite"
require "json"
require "../entities/*"

module Repositories
    class Todo
        def initialize(database : String = "todo.db")
            @db = Nuummite.new("../storage", database)
        end

        def store(task : Entities::Task)
            @db[task.id] = task.to_json()
        end

        def update(task : Entities::Task)
            @db[task.id] = task.to_json()
        end

        def find(id : String)
            @db[id]? ? Entities::Task.from_json(@db[id]) : nil
        end

        def delete(id : String)
            @db.delete(id)
        end

        def all()
            items = [] of Entities::Task

            @db.each do |key, value|
                items << Entities::Task.from_json(value)
            end

            items
        end

        def clear()
            @db.shutdown()
        end
    end
end
