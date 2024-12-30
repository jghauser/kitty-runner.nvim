--
-- KITTY RUNNER | CONFIG
--

local cmd = vim.cmd
local nvim_set_keymap = vim.api.nvim_set_keymap
local random = math.random
local M = {}

-- create uuid
-- from https://gist.github.com/jrus/3197011
local function get_uuid()
  math.randomseed(tonumber(tostring(os.time()):reverse():sub(1, 9)))
  local template = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
  return string.gsub(template, '[xy]', function(c)
    local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
    return string.format('%x', v)
  end)
end

M.uuid = get_uuid

local uuid = get_uuid()

-- default configulation values
local default_config = {
  runner_name = "kitty-runner-" .. uuid,
  run_cmd = { "send-text", "--" },
  kill_cmd = { "close-window" },
  use_keymaps = true,
  kitty_port = "unix:/tmp/kitty-" .. uuid,
  mode = "os-window"
}

local window_config = {
  runner_name = "kitty-runner-" .. uuid,
  run_cmd = { "send-text", "--match=title:" .. "kitty-runner-" .. uuid },
  kill_cmd = { "close-window", "--match=title:" .. "kitty-runner-" .. uuid },
  use_keymaps = true,
  kitty_port = "unix:/tmp/kitty",
  mode = "window"
}

M = vim.deepcopy(default_config)
M.default_config = default_config
M.window_config = window_config

-- configuration update function
M.update = function(opts)
  local newconf = vim.tbl_deep_extend("force", default_config, opts or {})
  for k, v in pairs(newconf) do
    M[k] = v
  end
end

-- define default commands
M.define_commands = function()
  cmd([[
    command! KittyReRunCommand lua require('kitty-runner').re_run_command()
    command! -range KittySendLines lua require('kitty-runner').run_command(vim.region(0, vim.fn.getpos("'<"), vim.fn.getpos("'>"), "l", false)[0])
    command! KittyRunCommand lua require('kitty-runner').prompt_run_command()
    command! KittyClearRunner lua require('kitty-runner').clear_runner()
    command! KittyOpenRunner lua require('kitty-runner').open_runner()
    command! KittyKillRunner lua require('kitty-runner').kill_runner()
  ]])
end

-- define default keymaps
M.define_keymaps = function()
  nvim_set_keymap("n", "<leader>tr", ":KittyRunCommand<cr>",
    { silent = true, desc = "Run a command in a Kitty runner" })
  nvim_set_keymap("x", "<leader>ts", ":KittySendLines<cr>", { silent = true, desc = "Send lines to a Kitty runner" })
  nvim_set_keymap("n", "<leader>ts", ":KittySendLines<cr>", { silent = true, desc = "Send lines to a Kitty runner" })
  nvim_set_keymap("n", "<leader>tc", ":KittyClearRunner<cr>",
    { silent = true, desc = "Clear the screen in the Kitty runner" })
  nvim_set_keymap("n", "<leader>tk", ":KittyKillRunner<cr>", { silent = true, desc = "Kill the Kitty runner" })
  nvim_set_keymap("n", "<leader>tl", ":KittyReRunCommand<cr>",
    { silent = true, desc = "Re-run the last Kitty runner command" })
  nvim_set_keymap("n", "<leader>to", ":KittyOpenRunner<cr>", { silent = true, desc = "Open a Kitty runner" })
end

return M
