return {
  "jake-stewart/multicursor.nvim",
  branch = "1.0",
  event = "VeryLazy",
  config = function()
    local mc = require("multicursor-nvim")
    mc.setup()

    local set = vim.keymap.set

    -- Add cursor to next match of word/selection
    set({ "n", "x" }, "gl", function()
      mc.matchAddCursor(1)
    end, { desc = "Add cursor to next match" })

    -- Add cursors to all matches in buffer
    set({ "n", "x" }, "ga", mc.matchAllAddCursors, { desc = "Add cursors to all matches" })

    -- Skip current match and find next
    set({ "n", "x" }, "gL", function()
      mc.matchSkipCursor(1)
    end, { desc = "Skip match and find next" })

    -- Vertical hola addition
    set({ "n", "x" }, "<C-j>", function()
      mc.lineAddCursor(1)
    end, { desc = "Add cursor below" })
    set({ "n", "x" }, "<C-k>", function()
      mc.lineAddCursor(-1)
    end, { desc = "Add cursor above" })

    -- Skip lines vertically
    set({ "n", "x" }, "<leader><C-j>", function()
      mc.lineSkipCursor(1)
    end, { desc = "Skip cursor below" })
    set({ "n", "x" }, "<leader><C-k>", function()
      mc.lineSkipCursor(-1)
    end, { desc = "Skip cursor above" })

    -- Mouse support
    set("n", "<C-LeftMouse>", mc.handleMouse, { desc = "Add/remove cursor with Ctrl+Click" })

    -- Toggle cursors on/off
    set({ "n", "x" }, "<C-q>", mc.toggleCursor, { desc = "Toggle cursor enable/disable" })

    -- Keymap layer: only active when multiple cursors exist
    mc.addKeymapLayer(function(layerSet)
      layerSet({ "n", "x" }, "<Left>", mc.prevCursor, { desc = "Go to previous cursor" })
      layerSet({ "n", "x" }, "<Right>", mc.nextCursor, { desc = "Go to next cursor" })
      layerSet({ "n", "x" }, "<leader>x", mc.deleteCursor, { desc = "Delete current cursor" })
      layerSet("n", "<Esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        else
          mc.clearCursors()
        end
      end, { desc = "Enable cursors or clear all" })
    end)

    -- Cursor highlights
    local hl = vim.api.nvim_set_hl
    hl(0, "MultiCursorCursor", { link = "Cursor" })
    hl(0, "MultiCursorVisual", { link = "Visual" })
    hl(0, "MultiCursorSign", { link = "SignColumn" })
    hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
    hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
  end,
}
