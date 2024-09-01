# Contributing

## How to contribute

- Make a pull request

## Requirements

Of course, you need to have [Neovim](https://neovim.io/) installed.

### Plugins

- `nvim-lua/plenary.nvim` - for testing
- `echasnovski/mini.doc` - for documentation
- `folke/neodev.nvim` - (optional)

```lua
require("neodev").setup({
    override = function(_, library)
        library.enabled = true
        library.plugins = true
    end,
})
```

## How to run tests

To run the tests, you need to have the [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) plugin installed.

To test the current file, run the following command inside neovim:

```lua
:PlenaryBustedFile %
```

To test all files, run the following from the command line:

```bash
nvim --headless -c ':lua require("plenary")' -c 'PlenaryBustedDirectory lua/tests'
```

## How to document

We use [mini.doc](https://github.com/echasnovski/mini.doc) for documentation.

### How to write documentation

Use `---` for documentation comments and `---@` for annotations.

Some annotations are:

- `@param {name} {type}` for parameters
- `@return {type}` for return values
- `@usage {example}` for usage examples

Example:

```lua
-- Setup the plugin
--
--@param opts table Options to override the default configuration
--
--@usage `require("seshmgr").setup({})` (replace `{}` with your `configuration`)
```

### How to generate documentation

To generate documentation:

- Run `:lua MiniDoc.generate()` in Neovim
- Run `scripts/generate-docs.sh` in the terminal
  - Needs `mini.doc` installed in `~/.local/share/nvim/site/pack/vendor/start`
