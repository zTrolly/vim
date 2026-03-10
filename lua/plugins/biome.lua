return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      local supported = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "json",
        "jsonc",
        "css",
      }

      for _, ft in ipairs(supported) do
        if opts.formatters_by_ft[ft] then
          for i, formatter in ipairs(opts.formatters_by_ft[ft]) do
            if formatter == "biome" then
              opts.formatters_by_ft[ft][i] = "biome-check"
            end
          end
        end
      end

      opts.formatters = opts.formatters or {}
      opts.formatters["biome-check"] = {
        require_cwd = true,
      }
    end,
  },
}
