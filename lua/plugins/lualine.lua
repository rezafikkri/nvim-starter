local Plugin = {'nvim-lualine/lualine.nvim'}

Plugin.name = 'lualine'

Plugin.event = 'VeryLazy'

-- See :help lualine.txt
Plugin.opts = {
  options = {
    theme = 'onedark',
    icons_enabled = true,
    component_separators = '|',
    section_separators = '',
    disabled_filetypes = {
			"NvimTree",
			"toggleterm",
		},
		always_divide_middle = true,
  },
	tabline = {},
	extensions = {},
}

function Plugin.init()
  vim.opt.showmode = false
end

return Plugin
