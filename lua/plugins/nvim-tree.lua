local Plugin = {'kyazdani42/nvim-tree.lua'}

Plugin.name = 'nvim-tree'

Plugin.cmd = {'NvimTreeToggle'}

-- See :help nvim-tree-setup
Plugin.opts = {
  hijack_cursor = false,
  on_attach = function(bufnr)
    local bufmap = function(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, {buffer = bufnr, desc = desc})
    end

    -- :help nvim-tree.api
    local api = require('nvim-tree.api')

    bufmap('<CR>', api.node.open.edit, 'Expand folder or go to file')
    bufmap('H', api.node.navigate.parent_close, 'Close parent folder')
    bufmap('gh', api.tree.toggle_hidden_filter, 'Toggle hidden files')
    bufmap('a', api.fs.create, 'Create new file')
    bufmap('r', api.fs.rename, 'Rename file name')
    bufmap('x', api.fs.cut, 'Cut file')
    bufmap('p', api.fs.paste, 'Paste file')
    bufmap('D', api.fs.trash, 'Trash file')
  end
}

function Plugin.init()
  vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>')
end

return Plugin
