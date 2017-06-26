require "nuummite"
require "json"
require "../entities/*"

module Repositories
    class Todo
        def initialize
            @db = Nuummite.new("../storage", "todo.db")
        end

        def add(task : Entities::Task)
            @db[task.id] = task.to_json()
        end

        def edit(task : Entities::Task)
            @db[task.id] = task.to_json()
        end

        def find(id : String)
            @db[id]
        end

        def all()
            items = [] of Hash(String, String)

            @db.each do |key, value|
                puts JSON.parse(value)
            end

            items
        end
    end
end
