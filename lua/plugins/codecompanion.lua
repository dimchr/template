return {
  "olimorris/codecompanion.nvim",
  config = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- "j-hui/fidget.nvim", -- Display status
    "ravitemer/codecompanion-history.nvim", -- Save and load conversation history
    {
      "ravitemer/mcphub.nvim", -- Manage MCP servers
      cmd = "MCPHub",
      build = "npm install -g mcp-hub@latest",
      config = true,
    },
    {
      "Davidyz/VectorCode", -- Index and search code in your repositories
      version = "*",
      build = "pipx upgrade vectorcode",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
      "HakonHarnes/img-clip.nvim", -- Share images with the chat buffer
      event = "VeryLazy",
      cmd = "PasteImage",
      opts = {
        filetypes = {
          codecompanion = {
            prompt_for_file_name = false,
            template = "[Image]($FILE_PATH)",
            use_absolute_path = true,
          },
        },
      },
    },
    {
      "OXY2DEV/markview.nvim",
      lazy = false,
      opts = {
        preview = {
          filetypes = { "markdown", "codecompanion" },
          ignore_buftypes = {},
        },
      },
    },
    {
      "echasnovski/mini.diff",
      config = function()
        local diff = require("mini.diff")
        diff.setup({
          -- Disabled by default
          source = diff.gen_source.none(),
        })
      end,
    },
  },
  opts = {
    extensions = {
      history = {
        enabled = true,
        opts = {
          keymap = "gh",
          save_chat_keymap = "sc",
          auto_save = false,
          auto_generate_title = true,
          continue_last_chat = false,
          delete_on_clearing_chat = false,
          picker = "snacks",
          enable_logging = false,
          dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
        },
      },
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_vars = true,
          make_slash_commands = true,
          show_result_in_chat = true,
        },
      },
      vectorcode = {
        opts = {
          add_tool = true,
        },
      },
    },
    adapters = {
      gemini = function()
        return require("codecompanion.adapters").extend("gemini", {
          schema = {
            temperature = {
              order = 3,
              mapping = "parameters",
              type = "number",
              optional = true,
              default = 0.75,
              desc = "Controls the randomness of the output.",
              validate = function(n)
                return n >= 0 and n <= 2, "Must be between 0 and 2"
              end,
            },
            top_p = {
              order = 4,
              mapping = "parameters",
              type = "integer",
              optional = true,
              default = 0.95,
              desc = "The maximum cumulative probability of tokens to consider when sampling. The model uses combined Top-k and Top-p (nucleus) sampling. Tokens are sorted based on their assigned probabilities so that only the most likely tokens are considered. Top-k sampling directly limits the maximum number of tokens to consider, while Nucleus sampling limits the number of tokens based on the cumulative probability.",
              validate = function(n)
                return n > 0, "Must be greater than 0"
              end,
            },
          },
        })
      end,
    },
    prompt_library = {
    

    },
    strategies = {
      -- Change the default chat adapter
      chat = {
        adapter = "gemini",
        model = "gemini-2.5-flash-preview-05-20",
        keymaps = {
          send = {
            modes = {
              i = { "<C-CR>", "<C-s>" },
            },
          },
          completion = {
            modes = {
              i = "<C-x>",
            },
          },
        },
        slash_commands = {
          ["buffer"] = {
            keymaps = {
              modes = {
                i = "<C-b>",
              },
            },
          },
          ["fetch"] = {
            keymaps = {
              modes = {
                i = "<C-f>",
              },
            },
          },
          ["help"] = {
            opts = {
              max_lines = 1000,
            },
          },
          ["image"] = {
            keymaps = {
              modes = {
                i = "<C-i>",
              },
            },
            opts = {
              dirs = { "~/Documents/Screenshots" },
            },
          },
        },
      },
      inline = {
        adapter = "gemini",
        model = "gemini-2.5-pro-preview-05-06",
      },
    },
    display = {
      action_palette = {
        provider = "default",
      },
      chat = {
        -- show_references = true,
        -- show_header_separator = false,
        -- show_settings = false,
      },
      diff = {
        provider = "mini_diff",
      },
    },
    opts = {
      -- Set debug logging
      log_level = "DEBUG",
      -- system_prompt = function(opts)
      --   return ""
      -- end,
    },
    vim.keymap.set({ "n", "v" },  "C-a", ":CodeCompanionActions<CR>"),
    vim.keymap.set({ "v" },  "<Leader>as", ":CodeCompanionChat Add<CR>"),
    vim.keymap.set({ "n", "v" },  "<leader>aa", function()
      require("codecompanion").toggle()
    end, {desc ="Toggle CodeCompanion"} ),
    init = function()
      vim.cmd([[cab cc CodeCompanion]])
      -- require("plugins.custom.spinner"):init()
    end,
  }
}

