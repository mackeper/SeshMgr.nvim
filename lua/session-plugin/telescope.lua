local telescope = {}

vim.keymap.set("n", "<leader>js", function()
    local opts = {
        prompt_title = "Sessions",
        cwd = SessionPlugin.config.session_dir,
        previewer = false,
    }
    local finders = require("telescope.finders")
    local telescope_config = require("telescope.config").values
    local actions = require("telescope.actions")
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
        return displayer({ { Get_decoded_session_file_path(entry.name) }, { entry.readable_time } })
    end

    require("telescope.pickers")
        .new(opts, {
            finder = finders.new_table({
                results = Get_sessions(),
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
                actions.select_default:replace(load_session)
                return true
            end,
        })
        :find()
end, {
    noremap = true,
    desc = "Sessions",
})

return telescope
