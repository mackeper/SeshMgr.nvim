describe("telescope", function()
    it("should return a table", function()
        local telescope = require("seshmgr.telescope")
        assert(telescope ~= nil)
    end)

    it("keymaps should return a table", function()
        local telescope = require("seshmgr.telescope")
        telescope.setup_keymaps("js", "/tmp", "!")
        local keymaps = vim.api.nvim_get_keymap("n")
        for _, keymap in ipairs(keymaps) do
            print(keymap.lhs)
            if keymap.lhs == "js" then
                print(vim.inspect(keymap))
                -- assert(keymap.rhs == ":lua require('seshmgr.telescope')._search_session('/tmp', '!')<CR>")
            end
        end
    end)
end)
