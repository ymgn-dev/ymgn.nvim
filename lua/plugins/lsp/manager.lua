local mason_lsp_ensure_installed = {
  bashls = {},
  cssls = {},
  eslint = {},
  html = {},
  jsonls = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
  marksman = {},
  prismals = {},
  spectral = {},
  sqlls = {},
  stylelint_lsp = {},
  svelte = {},
  tailwindcss = {},
  taplo = {},
  tsserver = {},
  yamlls = {},
}

-- https://github.com/williamboman/mason-lspconfig.nvim/issues/113
local non_lsp_ensure_installed = {
  -- Linters
  'codespell',
  'jsonlint',
  'luacheck',
  'markdownlint',
  'shellcheck',
  'sqlfluff',
  'stylelint',
  'yamllint',

  -- formatters
  'shfmt',
  'stylua',
}

local function check_non_lsps_installed()
  local registry = require('mason-registry')
  for _, pkg_name in ipairs(non_lsp_ensure_installed) do
    local ok, pkg = pcall(registry.get_package, pkg_name)
    if ok then
      if not pkg:is_installed() then
        pkg:install()
      end
    end
  end
end

return {
  {
    'neovim/nvim-lspconfig',
    event = 'InsertEnter',
    dependencies = {
      -- https://github.com/williamboman/mason-lspconfig.nvim#setup
      { 'williamboman/mason.nvim', opts = {} },
      { 'williamboman/mason-lspconfig.nvim', opts = {} },
      { 'j-hui/fidget.nvim', tag = 'legacy', event = 'LspAttach', opts = {} },
      { 'folke/neodev.nvim', event = 'LspAttach', opts = {} },
    },
    keys = {
      { '[d', vim.diagnostic.goto_prev, desc = 'Go to previous diagnostic message' },
      { ']d', vim.diagnostic.goto_next, desc = 'Go to next diagnostic message' },
      { '<leader>e', vim.diagnostic.open_float, desc = 'Open floating diagnostic message' },
      { '<leader>q', vim.diagnostic.setloclist, desc = 'Open diagnostics list' },
    },
    config = function()
      local on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end
          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]amm')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

        nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        nmap('gt', vim.lsp.buf.type_definition, '[G]oto [T]ype [D]efinition')

        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
        -- nmap('<leader>fm', vim.lsp.buf.format, '[F]or[M]at')
      end

      check_non_lsps_installed()

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      local mason_lspconfig = require('mason-lspconfig')
      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(mason_lsp_ensure_installed),
      })
      mason_lspconfig.setup_handlers({
        function(server_name)
          require('lspconfig')[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = mason_lsp_ensure_installed[server_name],
            filetypes = (mason_lsp_ensure_installed[server_name] or {}).filetypes,
          })
        end,
      })
    end,
  },
}
