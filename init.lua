vim.cmd.colorscheme('habamax')

vim.opt.signcolumn = 'yes'
vim.opt.completeopt = {'menu', 'menuone', 'noinsert'}

local lsp_cmds = vim.api.nvim_create_augroup('lsp_cmds', {clear = true})

local function lsp_setup(opts)
  local setup_id
  local desc = 'Attach LSP server'
  local defaults = {
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    on_exit = vim.schedule_wrap(function()
      if setup_id then
        pcall(vim.api.nvim_del_autocmd, setup_id)
      end
    end),
  }

  local config = vim.tbl_deep_extend('force', defaults, opts)

  if config.filetypes == nil then
    return
  end

  local get_root = opts.root_dir
  if type(get_root) == 'function' then
    config.root_dir = nil
  end

  if opts.on_exit then
    local cb = opts.on_exit
    local cleanup = defaults.on_exit
    config.on_exit = function(...)
      cleanup()
      cb(...)
    end
  end

  if config.name then
    desc = string.format('Attach LSP: %s', config.name)
  end

  local start_client = function()
    if get_root then
      config.root_dir = get_root()
    end

    if config.root_dir then
      vim.lsp.start(config)
    end
  end

  setup_id = vim.api.nvim_create_autocmd('FileType', {
    group = lsp_cmds,
    pattern = config.filetypes,
    desc = desc,
    callback = start_client
  })
end

local function find_first(list)
  local result = vim.fs.find(list, {
    upward = true,
    limit = 1,
    stop = vim.env.HOME,
  })

  local path = result[1]

  if path == nil then
    return
  end

  if vim.fn.isdirectory(path) == 1 then
    return path
  end

  return vim.fs.dirname(path)
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
    bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
    bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
    bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

    bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
    bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')

    -- if using Neovim v0.8 uncomment this
    -- bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
  end
})

lsp_setup({
  name = 'lua_ls',
  cmd = {'lua-language-server'},
  filetypes = {'lua'},
  root_dir = function()
    return find_first({'.luarc.json'})
  end,
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
  root_dir = function()
    return find_first({'package.json'})
  end,
})

