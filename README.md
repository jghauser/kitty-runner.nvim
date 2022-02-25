# kitty-runner.nvim

A neovim plugin written in lua that allows you to easily send lines from the current buffer to another kitty terminal. I use it mostly as a poor man's REPL, e.g. I start ipython in the kitty terminal and send buffer lines to it.

This plugin is inspired by and heavily borrows from [vim-kitty-runner](https://github.com/LkeMitchll/vim-kitty-runner).

# Functionality

The plugin implements the following commands:
- `:KittySendLines`: Send the line at the current cursor position or the lines of current visual selection
- `:KittyRunCommand`: Prompt for a command and send it
- `:KittyReRunCommand`: Send the last command
- `:KittyClearRunner`: Clear the runner's screen
- `:KittyKillRunner`: Kill the runner

By default a number of keymaps are created (see below to turn this off):
- `<leader>tr`: `:KittyRunCommand`
- `<leader>ts`: `:KittySendLines`
- `<leader>tc`: `:KittyClearRunner`
- `<leader>tk`: `:KittyKillRunner`
- `<leader>tl`: `:KittyReRunCommand`

This plugin may require neovim 0.5. It has only been tested on Linux. Let me know if you found any problems or have ideas for improvement!

## Installation

With packer:

```lua
use {
  'jghauser/kitty-runner.nvim',
  config = function()
    require('kitty-runner').setup()
  end
}
```

## Configuration

The setup function allows adjusting various settings. By default it sets the following:

```lua

require('kitty-runner').setup({
  use_keymaps = true --use keymaps
  run_cmd = {'send-text', '--match=title:' .. Cfg.runner_name} --kitty arguments when sending lines/command
  kill_cmd = {'close-window', '--match=title:' .. Cfg.runner_name} --kitty arguments when killing a runner
})


```

## TODO

- Find a non-hacky way of running a command *and* spawning the terminal on first invocation
- Improve code legibility and comments
- Documentation
