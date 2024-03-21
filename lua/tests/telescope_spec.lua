local function has_keymap(keymap)
    local keymaps = vim.api.nvim_get_keymap("n")
    for _, k in ipairs(keymaps) do
        if k.lhs == keymap then
            return true
        end
    end
    return false
end

describe("telescope", function()
    it("should return a table", function()
        local telescope = require("seshmgr.telescope")
        assert(telescope ~= nil)
    end)

    it("keymaps should return a table", function()
        -- Arrange
        local keymap = "js"
        local telescope = require("seshmgr.telescope")
        assert(not has_keymap(keymap), string.format("keymap '%s' should not exist", keymap))

        -- Act
        telescope.setup_keymaps(keymap, "/tmp", "!")

        -- Assert
        assert(has_keymap(keymap), string.format("keymap '%s' should exist", keymap))
    end)
end)
