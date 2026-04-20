return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.diagnostics = opts.diagnostics or {}
    opts.diagnostics.update_in_insert = false
  end,
}
