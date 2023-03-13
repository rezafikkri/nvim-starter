vim.cmd.colorscheme('habamax')

vim.opt.signcolumn = 'yes'
vim.opt.completeopt = {'menu', 'menuone', 'noinsert'}

local lsp_cmds = vim.api.nvim_create_augroup('lsp_cmds', {clear = true})

local function lsp_setup(user_opts)
  local desc = 'Attach LSP server'
  local defaults = {capabilities = vim.lsp.protocol.make_client_capabilities()}

  local config = vim.tbl_deep_extend('force', defaults, user_opts)

  if config.name then
    desc = string.format('Attach LSP: %s', config.name)
  end

  local start_client = function()
    if config.root_files then
      local path = vim.fs.find(config.root_files, {upward = true, limit = 1})
      config.root_dir = vim.fs.dirname(path[1])
    end

    vim.lsp.start(config)
  end

  vim.api.nvim_create_autocmd('FileType', {
    group = lsp_cmds,
    pattern = config.filetypes,
    desc = desc,
    callback = start_client
  })
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = lsp_cmds,
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, {buffer = true})
    end

    -- Trigger LSP completion
    bufmap('i', '<C-Space>', '<C-x><C-o>')

    bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
    bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
    bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
    bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
    bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
    bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
    bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
    bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
    bufmap({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
    bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
})

lsp_setup({
  name = 'lua_ls',
  cmd = {'lua-language-server'},
  filetypes = {'lua'},
  root_files = {'.luarc.json'},
})

lsp_setup({
  name = 'tsserver',
  cmd = {'typescript-language-server', '--stdio'},
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx'
  },
  root_files = {'package.json'},
})

