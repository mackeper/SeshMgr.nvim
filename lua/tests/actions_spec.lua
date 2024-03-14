local actions = require("session-plugin.actions")

describe("actions", function()
    it("should return a table", function()
        require("session-plugin.actions")
    end)

    it("should have a load function", function()
        assert.is_function(actions.load)
    end)

    it("should have a save function", function()
        assert.is_function(actions.save)
    end)

    it("should have a delete function", function()
        assert.is_function(actions.delete)
    end)

    it("should have an exists function", function()
        assert.is_function(actions.exists)
    end)

    it("should have a get_sessions function", function()
        assert.is_function(actions.get_sessions)
    end)

    it("should have a get_session_file function", function()
        assert.is_function(actions.get_session_file)
    end)
end)
