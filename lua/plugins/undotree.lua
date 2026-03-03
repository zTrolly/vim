return {
  "jiaoshijie/undotree",
  keys = {
    {
      "<leader>U",
      function()
        require("undotree").toggle()
      end,
      desc = "Toggle Undotree",
    },
  },
  config = function()
    require("undotree").setup({})
  end,
}
