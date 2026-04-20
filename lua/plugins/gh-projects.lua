return {
  {
    "ifloresarg/gh-projects",
    config = function()
      require("gh-projects").setup({
        binary = "gh projects",
        width = 0.8,
        height = 0.8,
        border = "rounded",
      })
    end,
    keys = {
      { "<leader>gx", "<cmd>GhProjects<cr>", desc = "Open GitHub Projects" },
    },
  },
}
