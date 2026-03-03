return {
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")

      if not dap.adapters["pwa-node"] then
        require("dap").adapters["pwa-node"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            args = {
              require("mason-registry").get_package("js-debug-adapter"):get_install_path()
                .. "/js-debug/src/dapDebugServer.js",
              "${port}",
            },
          },
        }
      end

      dap.configurations.typescript = dap.configurations.typescript or {}

      table.insert(dap.configurations.typescript, {
        type = "pwa-node",
        request = "launch",
        name = "NestJS: Debug (tad-api)",
        runtimeExecutable = "pnpm",
        runtimeArgs = { "run", "start:debug" },
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        sourceMaps = true,
        skipFiles = { "<node_internals>/**", "**/node_modules/**" },
        resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
      })

      table.insert(dap.configurations.typescript, {
        type = "pwa-node",
        request = "attach",
        name = "NestJS: Attach (port 9229)",
        port = 9229,
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        skipFiles = { "<node_internals>/**", "**/node_modules/**" },
        resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
      })
    end,
  },
}
