# kitty-runner.nvim
A neovim plugin written in lua that allows you to easily send lines from the current buffer to another kitty terminal. I use it mostly as a poor man's REPL, e.g. I start ipython in the kitty terminal and send buffer lines to it.

This plugin is inspired by and heavily borrows from [vim-kitty-runner](https://github.com/LkeMitchll/vim-kitty-runner). It was mostly created in an attempt to learn some lua and in a somewhat pointless effort to lua-fy my nevim setup. It's very much WIP and probably full of mistakes and/or inelegant code.

It currently (attempts) to do the following:

- When first running `:KittySendLines` or `:KittyRunCommand`, a new kitty terminal is spawned (the 'runner').
- Further instances of running these commenands do the following
  - `:KittySendLines`: Sends the line of the current cursor position or current visual selection.
  - `:KittyRunCommand`: Prompts for a command and sends it.
- `:KittyReRunCommand`: Sends the last command.
- `:KittyClearRunner`: Clears the screen of the runner terminal.
- `:KittyKillRunner`: Kills the runner terminal.
- By default a number of keymaps are created; this behaviour can be turned off in the setup function.
  - `<leader>tr`: `:KittyRunCommand`
  - `<leader>ts`: `:KittySendLines`
  - `<leader>tc`: `:KittyClearRunner`
  - `<leader>tk`: `:KittyKillRunner`
  - `<leader>tl`: `:KittyReRunCommand`

This plugin may require neovim 0.5.

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
  run_cmd = {'send-text', '--match=title:' .. Cfg.runner_name} --kitty arguments when sending lines/command
  kill_cmd = {'close-window', '--match=title:' .. Cfg.runner_name} --kitty arguments when killing a runner
  use_keymaps = true --use keymaps
})


```

## TODO

- First time the commands are run should spawn the terminal AND run the commands
- Improve code legibility and comments
