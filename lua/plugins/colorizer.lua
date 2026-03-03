return {
  "norcalli/nvim-colorizer.lua",
  event = "VeryLazy",
  config = function()
    require("colorizer").setup({
      "*",
    }, {
      RGB = true,
      RRGGBB = true,
      names = false,
      RRGGBBAA = true,
      rgb_fn = true,
      hsl_fn = true,
      mode = "background",
    })
  end,
}
