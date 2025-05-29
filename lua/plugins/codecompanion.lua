return {
  "olimorris/codecompanion.nvim",
  config = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    strategies = {
      -- Change the default chat adapter
      chat = {
        adapter = "gemini",
      },
      inline = {
        adapter = "gemini",
      },
    },
    opts = {
      -- Set debug logging
      log_level = "DEBUG",
    },
    vim.keymap.set({ "n", "v", "x" },  "<leader>;c", function()
      require("codecompanion").toggle()
    end, {desc ="Toggle CodeCompanion"} ),
    vim.keymap.set({ "n", "v", "x" },  "<leader>;;", ":CodeCompanionActions<CR>"),
    vim.cmd([[cab cc CodeCompanion]])
  }
}
