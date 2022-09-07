--
-- KITTY RUNNER | CONFIG
--

local cmd = vim.cmd
local nvim_set_keymap = vim.api.nvim_set_keymap

-- get uuid
local function get_uuid()
	local uuid_handle = io.popen([[uuidgen]])
	local uuid = uuid_handle:read("*l")
	uuid_handle:close()
	return uuid
end

local uuid = get_uuid()

-- default configulation values
local default_config = {
	runner_name = "kitty-runner-" .. uuid,
	run_cmd = { "send-text" },
	kill_cmd = { "close-window" },
	use_keymaps = true,
	kitty_port = "unix:/tmp/kitty-" .. uuid,
}

local M = vim.deepcopy(default_config)

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
	nvim_set_keymap("n", "<leader>tr", ":KittyRunCommand<cr>", { silent = true })
	nvim_set_keymap("x", "<leader>ts", ":KittySendLines<cr>", { silent = true })
	nvim_set_keymap("n", "<leader>ts", ":KittySendLines<cr>", { silent = true })
	nvim_set_keymap("n", "<leader>tc", ":KittyClearRunner<cr>", { silent = true })
	nvim_set_keymap("n", "<leader>tk", ":KittyKillRunner<cr>", { silent = true })
	nvim_set_keymap("n", "<leader>tl", ":KittyReRunCommand<cr>", { silent = true })
	nvim_set_keymap("n", "<leader>to", ":KittyOpenRunner<cr>", { silent = true })
end

return M
