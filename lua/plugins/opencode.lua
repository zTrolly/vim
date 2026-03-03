return {
  {
    "sudo-tee/opencode.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          anti_conceal = { enabled = false },
          file_types = { "markdown", "opencode_output" },
        },
        ft = { "markdown", "opencode_output" },
      },
      "saghen/blink.cmp",
      "folke/snacks.nvim",
    },
    config = function()
      require("opencode").setup({
        default_mode = "prometheus",
        keymap = {
          editor = {
            ["<leader>oa"] = { "select_agent", desc = "Select agent" },
          },
        },
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "opencode",
        callback = function()
          vim.opt_local.textwidth = 80
          vim.opt_local.formatoptions:append("t")
        end,
      })
    end,
  },
}
