require "json"
require "uuid"

module Entities
    class Task
        JSON.mapping(
            id: String,
            description: String,
            done: Bool
        )

        def initialize(description : String, done : Bool = false)
            @id = UUID.generate
            @description = description
            @done = done
        end
    end
end