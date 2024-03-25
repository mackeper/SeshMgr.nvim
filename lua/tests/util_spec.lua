local util = require("seshmgr.util")

describe("util", function()
    it("should return a table", function()
        assert(util ~= nil)
    end)

    it("_get_encoded_cwd should return the current working directory with a different delimiter", function()
        -- Arrange
        local delimiter = "_-_"

        -- Act
        local encoded_cwd = util._get_encoded_cwd(delimiter)

        -- Assert
        -- BUG: the assertion below is equivalent to the tested function
        assert(encoded_cwd == vim.fn.substitute(vim.fn.getcwd(), "/", delimiter, "g"))
    end)

    it("_get_decoded_session_file_path should return the original cwd", function()
        -- Arrange
        local encoded_cwd = "!test!seshmgr!tmp"
        local delimiter = "!"

        -- Act
        local decoded_cwd = util._get_decoded_session_file_path(encoded_cwd, delimiter)

        -- Assert
        assert(decoded_cwd == "/test/seshmgr/tmp")
    end)
end)
