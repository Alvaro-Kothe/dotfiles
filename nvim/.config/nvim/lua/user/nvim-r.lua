vim.cmd "let R_assign_map = '<M-->'"
-- vim.cmd 'let R_auto_omni = ["r", "rmd", "quarto", "rnoweb", "rhelp"]'

local status_ok, _ = pcall(require, "nvim-r")
if not status_ok then
	return
end

