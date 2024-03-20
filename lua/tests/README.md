# Tests

## Running tests

To run the tests, you need to have the [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) plugin installed.

To test the current file, run the following command inside neovim:
```lua
:PlenaryBustedFile %
```

To test all files, run the following from the command line:
```bash
nvim --headless -c ':lua require("plenary")' -c 'PlenaryBustedDirectory lua/tests'
```
