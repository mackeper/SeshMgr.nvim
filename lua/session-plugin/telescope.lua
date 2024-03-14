local actions = require("session-plugin.actions")
local util = require("session-plugin.util")

-- TODO: Make this an extension?
local telescope = {}

-- Search for sessions
-- @param session_dir string: The directory where the session files are saved
-- @param delimiter string: The delimiter to use in the session file name
telescope.search_session = function(session_dir, delimiter)
    local opts = {
        prompt_title = "Sessions",
        cwd = session_dir,
        previewer = false,
    }

    local finders = require("telescope.finders")
    local telescope_config = require("telescope.config").values
    local telescope_actions = require("telescope.actions")
    local entry_display = require("telescope.pickers.entry_display")
    local make_entry = require("telescope.make_entry")

    local displayer = entry_display.create({
        separator = "   ",
        items = {
            { width = 0.7 },
            { width = 0.25, right_justify = true },
        },
    })

    local make_display = function(entry)
        return displayer({ { util.get_decoded_session_file_path(entry.name, delimiter) }, { entry.readable_time } })
    end

    require("telescope.pickers")
        .new(opts, {
            finder = finders.new_table({
                results = actions.get_sessions(session_dir),
                entry_maker = function(entry)
                    entry.value = entry
                    entry.display = make_display
                    entry.ordinal = entry.name
                    return make_entry.set_default_entry_mt(entry, opts)
                end,
            }),
            previewer = telescope_config.grep_previewer(opts),
            sorter = telescope_config.file_sorter(opts),
            attach_mappings = function(prompt_bufnr, map)
                local load_session = function()
                    local selection = require("telescope.actions.state").get_selected_entry()
                    require("telescope.actions").close(prompt_bufnr)
                    vim.cmd("source " .. selection.value.path)
                end
                telescope_actions.select_default:replace(load_session)
                return true
            end,
        })
        :find()
end

-- Setup the telescope keymaps
-- @param keymap string: The keymap to use
-- @param session_dir string: The directory where the session files are saved
-- @param delimiter string: The delimiter to use in the session file name
telescope.setup_keymaps = function(keymap, session_dir, delimiter)
    vim.keymap.set("n", keymap, function()
        telescope.search_session(session_dir, delimiter)
    end, {
        noremap = true,
        desc = "Sessions",
    })
end

return telescope
